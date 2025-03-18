# frozen_string_literal: true

module LlmTools
  class Chat
    def submit(prompt:)
      raw_response = OpenAi::Client.new.chat_completion(prompt:)
      raw_response['choices'][0]
    rescue NoMethodError => error
      Rails.logger.error("### OpenAi::Client ###\n #{raw_response}\nChat error: #{error.message}")
    end
  end
end
