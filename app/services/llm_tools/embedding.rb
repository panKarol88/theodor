# frozen_string_literal: true

module LlmTools
  class Embedding
    def initialize(input:)
      @input = input
    end

    def embed
      OpenAi::Client.new.embed(input:)
    end

    private

    attr_reader :input
  end
end
