# frozen_string_literal: true

module Prompt
  module DecoratorStrategies
    class DefaultStrategy
      def initialize(prompt:, prompt_decorator:, input: '')
        @prompt = prompt
        @input = input
        @decoration = prompt_decorator.value
      end

      def decorate
        return decorated_prompt unless contains_text_variable?

        "#{prompt}\\n#{decoration.gsub('{{text}}', input)}"
      end

      private

      attr_reader :prompt, :input, :decoration

      def decorated_prompt
        "#{decoration}\\n#{prompt}"
      end

      def contains_text_variable?
        decoration.include?('{{text}}')
      end
    end
  end
end
