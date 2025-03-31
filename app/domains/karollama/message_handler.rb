module Karollama
  class MessageHandler
    include Helpers::LlmInterface
    include Utils::MessageHandlerInterface

    MODEL = 'gpt-4o-mini'.freeze
    WAREHOUSE_NAME = 'karollama'.freeze
    LANGFUSE_PROMPT_NAME = 'karollama'.freeze
    LANGFUSE_FUNNEL = 'karollama'.freeze
    CONTEXT_LIMIT = 20

    def initialize(message:, session_id: nil, model: MODEL, warehouse_name: WAREHOUSE_NAME, debug: false)
      @message = message
      @session_id = session_id
      @model = model
      @warehouse = Warehouse.find_by!(name: warehouse_name)
      @debug = debug
    end

    def process_message
      langfuse_client.process_with_langfuse do
        generate_chat_completion
      end
    rescue => e # rubocop:disable Style/RescueStandardError
      raise e unless debug

      "#{e.message}\n#{chat_response}\n#{e.backtrace.join("\n")}"
    end

    private

    attr_reader :message, :session_id, :model, :warehouse, :debug

    def generate_chat_completion
      raw_response = chat(prompt:, model:)
      response = parsed_chat_response(raw_response)
      ConversationMessage.create!(user_message: message, bot_message: response)

      [raw_response, response]
    end

    def langfuse_client
      @langfuse_client ||= Langfuse::Client.new(prompt_name: LANGFUSE_PROMPT_NAME, variables:, session_id:, model:, funnel: LANGFUSE_FUNNEL)
    end

    def prompt
      langfuse_client.final_prompt
    end

    def variables
      { context_information:, message: }
    end

    def context_information
      @context_information ||= Context::KnowledgeCollector.new(
        issue: message,
        warehouse:
      ).find_related_data_crumbs(
        limit: CONTEXT_LIMIT
      ).map(&:content).join("\n")
    end
  end
end
