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

    def embed_and_initialize
      data_crumb = DataCrumb.new(content: input, warehouse:)
      return data_crumb unless data_crumb.valid?

      embedding = LlmTools::Embedding.new(input:).embed
      data_crumb.assign_attributes(embedding:)
      data_crumb
    end

    private

    attr_reader :input, :warehouse
  end
end
