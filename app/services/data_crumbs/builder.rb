# frozen_string_literal: true

module DataCrumbs
  class Builder
    include Helpers::LlmInterface

    def initialize(input:, warehouse:)
      @input = input
      @warehouse = warehouse
    end

    def embed_and_create!
      embed_and_create
    end

    def embed_and_initialize
      DataCrumb.new(content: input, embedding: embed(input), warehouse:)
    end

    def edit_input_with(_edit_input_strategies:)
      input
    end

    private

    attr_reader :input, :warehouse

    def embed_and_create
      DataCrumb.create!(content: input, embedding: embed(input), warehouse:)
    end
  end
end
