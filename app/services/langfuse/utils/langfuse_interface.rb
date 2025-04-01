# frozen_string_literal: true

module Langfuse
  module Utils
    module LangfuseInterface
      def secret_key
        ENV.fetch('LANGFUSE_SECRET_KEY', nil)
      end

      def public_key
        ENV.fetch('LANGFUSE_PUBLIC_KEY', nil)
      end

      def api_url
        ENV.fetch('LANGFUSE_API_URL', 'https://cloud.langfuse.com/api/public')
      end

      def generate_uuid
        SecureRandom.uuid
      end

      def parsed_chat_response(chat_response)
        JSON.parse(chat_response[:content])['answer']
      end

      def http(url)
        @http ||= Net::HTTP.new(url.host, url.port).tap do |http|
          http.use_ssl = true
        end
      end

      def basic_auth_token
        Base64.strict_encode64("#{public_key}:#{secret_key}")
      end

      def langfuse_request(url:, body: nil, method: 'Get')
        request = Net::HTTP.const_get(method).new(url).tap do |req|
          req['Authorization'] = "Basic #{basic_auth_token}"
          req['Content-Type'] = 'application/json'
          req.body = body if body.present?
        end

        JSON.parse(http(url).request(request).read_body)
      end
    end
  end
end
