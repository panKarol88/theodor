# frozen_string_literal: true

module Helpers
  module PromptInterface
    def decorate(prompt:, prompt_decorator:, input: '')
      Prompt::DecoratorStrategies::DefaultStrategy.new(prompt:, prompt_decorator:, input:).decorate
    end
  end
end
