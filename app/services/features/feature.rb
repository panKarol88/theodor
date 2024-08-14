# frozen_string_literal: true

module Features
  class Feature
    RELATED_DATA_CRUMBS_LIMIT = 5

    include ::Helpers::LlmInterface
    include ::Helpers::PromptDecoratorsInterface

    def initialize(feature_record:, input:, warehouse:)
      @feature_record = feature_record
      @input = input
      @warehouse = warehouse
    end

    def process
      output = chat(prompt)

      return output unless feature_record.store_results?

      DataCrumbs::Builder.new(content: output, warehouse:).embed_and_create!
    end

    private

    attr_reader :feature_record, :input, :warehouse

    def prompt
      @prompt ||= prompt_decorators.map do |prompt_decorator|
        parse_prompt_decorator(prompt_decorator:, input:)
      end.join("\n")
    end

    def prompt_decorators
      @prompt_decorators ||= feature_record.prompt_decorators.priority_ordered
    end
  end
end
