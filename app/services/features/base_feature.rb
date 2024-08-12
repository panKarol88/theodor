# frozen_string_literal: true

module Features
  class BaseFeature
    include ::Helpers::LlmInterface
    include Helpers::PromptDecoratorHelper

    def initialize(feature_record:, input:)
      @feature_record = feature_record
      @input = input
    end

    def process
      prompt = prompt_decorators.map do |prompt_decorator|
        parse_prompt_decorator(prompt_decorator)
      end.join("\n")

      chat(prompt)
    end

    private

    attr_reader :feature_record, :input

    def prompt_decorators
      @prompt_decorators ||= feature_record.prompt_decorators.priority_ordered
    end
  end
end
