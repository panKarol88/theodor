# frozen_string_literal: true

module Helpers
  module LlmInterface
    def embed(input)
      LlmTools::Embedding.new(input:).embed
    end

    def chat(prompt)
      LlmTools::Chat.new.submit(prompt:)
    end

    def resource_bet(prompt)
      LlmTools::ResourceBet.new.submit(prompt:)
    end
  end
end
