module Karollama
  class MessageHandler
    include Utils::MessageHandlerInterface

    MODEL = 'gpt-4o-mini'.freeze
    WAREHOUSE_NAME = 'karollama'.freeze
    FUNNEL = 'karollama'.freeze
    CONTEXT_LIMIT = 20

    PROMPTS_COLLECTION = {
      triage: 'karollama_triage',
      get_information: 'karollama_get_information',
      request: 'karollama_request'
    }.freeze

    def initialize(warehouse_name:, prompt_broker: Langfuse::Client, session_id: nil, model: MODEL, debug: false)
      @prompt_broker = prompt_broker.new(funnel: FUNNEL, session_id:, model:)
      @session_id = session_id
      @model = model
      @warehouse = Warehouse.find_by!(name: warehouse_name || WAREHOUSE_NAME)
      @debug = debug
    end

    def process_message(message:)
      @message = message

      response = case triage
                 when :get_information
                   get_information
                 when :request
                   karollama_request
                 end

      create_conversation_message(response)
      prompt_broker.finalize_processing(response:)

      { response:, session_id: prompt_broker.session_id }
    end

    private

    attr_reader :message, :session_id, :model, :warehouse, :debug, :prompt_broker

    def triage
      prompt_name = PROMPTS_COLLECTION[:triage]
      variables = { message: }

      prompt_broker.process_message(message:, prompt_name:, variables:).to_sym
    end

    def get_information # rubocop:disable Naming/AccessorMethodName
      prompt_name = PROMPTS_COLLECTION[:get_information]
      previous_messages = ConversationMessage.where(session_id:).order(:created_at).map do |cm|
        cm.slice(:user_message, :bot_message).values
      end.flatten
      variables = { context_information:, previous_messages:, message: }

      prompt_broker.process_message(message:, prompt_name:, variables:)
    end

    def karollama_request
      raise NotImplementedError
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
      conversation_ids = prompt_broker.as_json.symbolize_keys.slice(:session_id, :trace_id, :generation_id)

      ConversationMessage.create!(
        user_message: message,
        bot_message: response,
        **conversation_ids
      )
    end
  end
end

# Karollama::MessageHandler.new.process_message(message: "who's karol")
