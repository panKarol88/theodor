# frozen_string_literal: true

module LlmTools
  class Chat
    def submit(prompt:, model: 'gpt-4o-mini')
      raw_response = OpenAi::Client.new.chat_completion(prompt:, model:)
      raw_response['choices'][0]
    rescue NoMethodError => e
      Rails.logger.error("### OpenAi::Client ###\n #{raw_response}\nChat error: #{e.message}")
      raise e
    end
  end
end
