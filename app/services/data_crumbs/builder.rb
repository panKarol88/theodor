# frozen_string_literal: true

module DataCrumbs
  class Builder
    include Helpers::LlmInterface
    include Helpers::PromptInterface

    def initialize(input:, warehouse:)
      @input = input
      @warehouse = warehouse
    end

    def prepare_input
      return self if warehouse.prompt_decorators.blank?

      @input = chat(edited_input_prompt)

      self
    end

    def embed_and_create!
      embed_and_create
    end

    def embed_and_initialize
      DataCrumb.new(content: input, embedding: embed(input), warehouse:)
    end

    private

    attr_reader :input, :warehouse, :data_crumb

    def edited_input_prompt
      prompt = ''
      warehouse.prompt_decorators.each do |prompt_decorator|
        prompt = decorate(prompt:, prompt_decorator:, input:)
      end

      prompt
    end

    def embed_and_create
      DataCrumb.create!(content: input, embedding: embed(input), warehouse:)
    end
  end
end
