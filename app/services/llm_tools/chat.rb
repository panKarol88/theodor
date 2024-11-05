# frozen_string_literal: true

module LlmTools
  class Chat
    def submit(prompt:)
      OpenAi::Client.new.chat_completion(prompt:)['choices'][0]
    end
  end
end
