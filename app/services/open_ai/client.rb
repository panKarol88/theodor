# frozen_string_literal: true

module OpenAi
  class Client
    include Utils::OpenAiInterface

    def embed(input:, model: 'text-embedding-ada-002', encoding_format: 'float')
      @url = URI("#{api_url}/embeddings")
      @body = { input:, model:, encoding_format: }.to_json
      open_ai_request['data'][0]['embedding']
    end

    def chat_completion(prompt:, model: 'gpt-4o', chat_completion_attrs: default_chat_completion_attrs)
      @url = URI("#{api_url}/chat/completions")
      messages = [{ content: prompt, role: 'user' }]
      @body = default_chat_completion_attrs.merge(chat_completion_attrs).compact.merge({ model:, messages: }).to_json
      open_ai_request
    end

    # */-----------------------------------------------------------/* #
    # vision_sources: ["data:image/png;base64,#{base64_image}"]
    def vision_info(prompt:, vision_sources: [], model: 'gpt-4o', chat_completion_attrs: default_chat_completion_attrs)
      @url = URI("#{api_url}/chat/completions")
      messages = [{
        role: 'user',
        content: [
          { type: 'text', text: prompt }
        ]
      }]
      vision_sources.each do |vision_source|
        messages[0][:content] << { type: 'image_url', image_url: { url: vision_source } }
      end
      @body = default_chat_completion_attrs.merge(chat_completion_attrs).compact.merge({ model:, messages: }).to_json
      open_ai_request
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
