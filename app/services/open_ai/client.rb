# frozen_string_literal: true

module OpenAi
  class Client
    include Utils::OpenAiInterface

    def embed(input:, model: 'text-embedding-ada-002', encoding_format: 'float')
      @url = URI("#{api_url}/embeddings")
      @body = { input:, model:, encoding_format: }.to_json
      open_ai_request['data'][0]['embedding']
    end

    def chat_completion(prompt:, model: 'gpt-4o', role: 'user', chat_completion_attrs: default_chat_completion_attrs)
      @url = URI("#{api_url}/chat/completions")
      messages = [{ content: prompt, role: }]
      @body = chat_completion_attrs.compact.merge({ model:, messages: }).to_json
      open_ai_request['choices'][0]['message']['content']
    end

    private

    attr_reader :url, :body

    def http
      @http ||= Net::HTTP.new(url.host, url.port).tap do |http|
        http.use_ssl = true
      end
    end

    def open_ai_request
      request = Net::HTTP::Post.new(url).tap do |req|
        req['Authorization'] = "Bearer #{api_key}"
        req['Content-Type'] = 'application/json'
        req.body = body
      end

      JSON.parse(http.request(request).read_body)
    end
  end
end
