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
      messages = prompt.is_a?(Array) ? prompt : [{ content: prompt, role: 'user' }]
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

    def image_generation(prompt:, size: '1024x1024', model: 'dall-e-3')
      @url = URI("#{api_url}/images/generations")
      @body = { prompt:, size:, model: }.to_json
      open_ai_request
    end

    def audio_transcription(file_dir:, model: 'whisper-1')
      @url = URI("#{api_url}/audio/transcriptions")
      form_data = [
        ["model", model],
        ["file", File.open(file_dir)]
      ]
      open_ai_request(form_data:)
    end

    private

    attr_reader :url, :body

    def http
      @http ||= Net::HTTP.new(url.host, url.port).tap do |http|
        http.use_ssl = true
      end
    end

    # TODO
    # :reek:FeatureEnvy
    def open_ai_request(form_data: nil)
      request = Net::HTTP::Post.new(url).tap do |req|
        req['Authorization'] = "Bearer #{api_key}"
        req['Content-Type'] = 'application/json'
        req.body = body

        if form_data.present?
          req['Content-Type'] = 'multipart/form-data'
          req.set_form(form_data, 'multipart/form-data')
        end
      end

      JSON.parse(http.request(request).read_body)
    end
  end
end
