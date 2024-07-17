# frozen_string_literal: true

module Helpers
  module PromptInterface
    def decorate(prompt:, prompt_decorator:, input: '')
      decorator_type = prompt_decorator.decorator_type
      decoration_strategy(decorator_type:).new(prompt:, prompt_decorator:, input:).decorate
    end

    private

    def decoration_strategy(decorator_type:)
      "Prompt::DecoratorStrategies::_#{decorator_type}_strategy".classify.safe_constantize || Prompt::DecoratorStrategies::DefaultStrategy
    end
  end
end
