module Karollama
  class MessageHandler
    include Helpers::LlmInterface

    DEFAULT_MODEL = 'gpt-4o-mini'.freeze
    DEFAULT_WAREHOUSE_NAME = 'karollama'.freeze
    DEFAULT_CONTEXT_LIMIT = 20

    def initialize(message:, model: DEFAULT_MODEL, warehouse_name: DEFAULT_WAREHOUSE_NAME, debug: false)
      @message = message
      @model = model
      @warehouse = Warehouse.find_by!(name: warehouse_name)
      @debug = debug
    end

    def process_message
      chat_response = OpenAi::Client.new.chat_completion(prompt: messages, model:)
      content = chat_response['choices'][0]['message']['content']
      JSON.parse(content)['answer']
    rescue => e # rubocop:disable Style/RescueStandardError
      raise e unless debug

      "#{e.message}\n#{chat_response}\n#{e.backtrace.join("\n")}"
    end

    private

    attr_reader :message, :model, :warehouse, :debug

    def context
      @context ||= Context::KnowledgeCollector.new(
        issue: message,
        warehouse:
      ).find_related_data_crumbs(
        limit: DEFAULT_CONTEXT_LIMIT
      ).map(&:content).join("\n")
    end

    def karollama_prompt
      YAML.load_file(File.join(__dir__, 'karollama_prompt.yml'))
    end

    def user_prompt
      { context_information: context, message: }.to_json
    end

    def system_prompt
      prompt_body = ''
      karollama_prompt.each do |key, value|
        paragraph = key.in?(%w[entry afterword]) ? "#{value}\n\n" : "<#{key}>\n#{value}\n</#{key}>\n"
        prompt_body << paragraph
      end

      prompt_body
    end

    def messages
      [
        { role: 'system', content: system_prompt },
        { role: 'user', content: user_prompt }
      ]
    end
  end
end
