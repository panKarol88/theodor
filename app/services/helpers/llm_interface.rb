# frozen_string_literal: true

module Helpers
  module LlmInterface
    def embed(input)
      LlmTools::Embedding.new(input:).embed
    end

    def chat(prompt)
      choice = LlmTools::Chat.new.submit(prompt:)
      response_object(choice)
    end

    def resource_bet(prompt)
      choice = LlmTools::ResourceBet.new.submit(prompt:)
      response_object(choice)
    end

    private

    def response_object(choice)
      content = choice.dig('message', 'content')
      logprobs_tokens = choice.dig('logprobs', 'content')
      probability = Shared::ProbabilityEstimator.new(logprobs_tokens:).count_probability

      { content:, probability: }
    end
  end
end
