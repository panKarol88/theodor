# frozen_string_literal: true

module OpenAi
  module Utils
    module OpenAiInterface
      def api_key
        ENV.fetch('OPEN_AI_API_KEY', nil)
      end

      def organization_id
        ENV.fetch('OPEN_AI_ORGANIZATION_ID', nil)
      end

      def api_url
        ENV.fetch('OPEN_AI_API_URL', 'https://api.openai.com/v1')
      end
    end
  end
end
