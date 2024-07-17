# frozen_string_literal: true

module Prompt
  module DecoratorStrategies
    class PostQuestionStrategy < DefaultStrategy
      private

      def decorated_prompt
        "#{prompt}\\n#{decoration}"
      end
    end
  end
end
