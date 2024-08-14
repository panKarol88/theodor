# frozen_string_literal: true

module Helpers
  module PromptDecoratorsInterface
    def input_context(issue:)
      @input_context ||= begin
        context_collector = Context::KnowledgeCollector.new(issue:, warehouse:)
        context_crumbs = context_collector.find_related_data_crumbs(limit: RELATED_DATA_CRUMBS_LIMIT)
        context_crumbs.map(&:content).join("\n")
      end
    end

    def parse_prompt_decorator(prompt_decorator:, input:)
      decoration = prompt_decorator.value

      return decoration.gsub('{{text}}', input) if decoration.include?('{{text}}')

      if decoration.include?('{{context}}')
        input_context = input_context(issue: input)
        return decoration.gsub('{{context}}', input_context)
      end

      decoration
    end
  end
end
