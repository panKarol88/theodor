module Karollama
  class MessageHandler
    include Helpers::LlmInterface
    include Utils::MessageHandlerInterface

    MODEL = 'gpt-4o-mini'.freeze
    WAREHOUSE_NAME = 'karollama'.freeze
    LANGFUSE_FUNNEL = 'karollama'.freeze
    CONTEXT_LIMIT = 20

    PROMPTS_COLLECTION = {
      triage: 'karollama_triage',
      get_information: 'karollama_get_information',
      request: 'karollama_request'
    }.freeze

    def initialize(message:, session_id: nil, model: MODEL, warehouse_name: WAREHOUSE_NAME, debug: false)
      @message = message
      @session_id = session_id
      @model = model
      @warehouse = Warehouse.find_by!(name: warehouse_name)
      @debug = debug
    end

    def process_message
      final_response = case triage
                       when :get_information
                         get_information
                       when :request
                         karollama_request
                       end

      create_conversation_message(final_response)
      final_response
    rescue => e # rubocop:disable Style/RescueStandardError
      raise e unless debug

      "#{e.message}\n#{chat_response}\n#{e.backtrace.join("\n")}"
    end

    private

    attr_reader :message, :session_id, :model, :warehouse, :debug

    def generate_chat_completion_with_langfuse(prompt_name:, variables:)
      langfuse_client.process_with_langfuse(prompt_name:, variables:) do
        decorated_prompt = langfuse_client.decorated_prompt
        raw_response = chat(prompt: decorated_prompt, model:)
        response = parsed_chat_response(raw_response)

        [raw_response, response]
      end
    end

    def triage
      generate_chat_completion_with_langfuse(prompt_name: PROMPTS_COLLECTION[:triage], variables: { message: })&.to_sym
    end

    def get_information # rubocop:disable Naming/AccessorMethodName
      prompt_name = PROMPTS_COLLECTION[:get_information]
      variables = { context_information:, message: }

      generate_chat_completion_with_langfuse(prompt_name:, variables:)
    end

    def karollama_request
      raise NotImplementedError
    end

    def langfuse_client
      @langfuse_client ||= Langfuse::Client.new(
        original_message: message,
        funnel: LANGFUSE_FUNNEL,
        session_id:,
        model:
      )
    end

    def context_information
      @context_information ||= Context::KnowledgeCollector.new(
        issue: message,
        warehouse:
      ).find_related_data_crumbs(
        limit: CONTEXT_LIMIT
      ).map(&:content).join("\n")
    end

    def create_conversation_message(response)
      conversation_ids = langfuse_client.as_json.symbolize_keys.slice(:session_id, :trace_id, :generation_id)

      ConversationMessage.create!(
        user_message: message,
        bot_message: response,
        **conversation_ids
      )
    end
  end
end

# Karollama::MessageHandler.new(message: "tell me something about Karol").process_message
