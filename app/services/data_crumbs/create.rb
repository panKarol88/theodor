# frozen_string_literal: true

module DataCrumbs
  class Create
    def initialize(input:, warehouse:)
      @input = input
      @warehouse = warehouse
    end

    def embed_and_create
      embedding = LlmTools::Embedding.new(input:).embed
      DataCrumb.create!(content: input, warehouse:, embedding:)
    end

    private

    attr_reader :input, :warehouse
  end
end
