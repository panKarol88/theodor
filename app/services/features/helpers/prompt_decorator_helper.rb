# frozen_string_literal: true

module Features
  module Helpers
    module PromptDecoratorHelper
      def parse_prompt_decorator(prompt_decorator)
        decoration = prompt_decorator.value

        return decoration unless decoration.include?('{{text}}')

        decoration.gsub('{{text}}', input)
      end
    end
  end
end
