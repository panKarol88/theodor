# frozen_string_literal: true

module Helpers
  module PromptDecoratorsInterface
    RELATED_DATA_CRUMBS_LIMIT = 5

    def input_context(issue:)
      @input_context ||= begin
        context_collector = Context::KnowledgeCollector.new(issue:, warehouse:)
        context_crumbs = context_collector.find_related_data_crumbs(limit: RELATED_DATA_CRUMBS_LIMIT)
        context_crumbs.map(&:content).join("\n")
      end
    end

    # TODO: Refactor
    # :reek:TooManyStatements
    def parse_prompt_decorator(prompt_decorator:, input:) # rubocop:disable Metrics/AbcSize
      decoration = prompt_decorator.value

      return decoration.gsub('{{text}}', input) if decoration.include?('{{text}}')

      if decoration.include?('{{context}}')
        input_context = input_context(issue: input)
        return decoration.gsub('{{context}}', input_context)
      end

      if decoration.include?('{{resources}}')
        resources = resource_collection.map { |record| { name: record.name, description: record.description } }
        return decoration.gsub('{{resources}}', resources.to_s)
      end

      return decoration.gsub('{{probability_properties}}', probability_properties.to_s) if decoration.include?('{{probability_properties}}')

      output_resource = thread_object.dig(:output, :resource)
      if decoration.include?('{{best_suggestion}}') && output_resource.present?
        return decoration.gsub('{{best_suggestion}}', output_resource)
      end

      decoration
    end
  end
end
