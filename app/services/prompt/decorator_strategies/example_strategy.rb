# frozen_string_literal: true

module Prompt
  module DecoratorStrategies
    class ExampleStrategy
      private

      def decorated_prompt
        "#{prompt}\\n#{decoration}"
      end
    end
  end
end
