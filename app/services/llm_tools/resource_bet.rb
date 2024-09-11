# frozen_string_literal: true

module LlmTools
  class ResourceBet
    RESOURCE_MODEL = 'gpt-4o-2024-08-06'

    def submit(prompt:)
      choice = OpenAi::Client.new.chat_completion(prompt:, model:, chat_completion_attrs:)['choices'][0]
      content = JSON.parse(choice.dig('message', 'content'))
      probability = count_probability(choice)

      content.merge(probability:).deep_symbolize_keys
    end

    private

    def count_probability(choice)
      contents = choice.dig('logprobs', 'content')
      important_contents = contents.select do |content|
        token = content['token']
        word?(token) && not_json_schema_key?(token)
      end

      important_contents.sum { |token| Math.exp(token['logprob']) } / important_contents.size
    end

    def chat_completion_attrs
      {
        response_format: {
          type: 'json_schema',
          json_schema: {
            name: 'resource_bet',
            schema: {
              type: 'object',
              properties: {
                resource: { type: 'string' }
              },
              required: %w[resource],
              additionalProperties: false
            },
            strict: true
          }
        },
        frequency_penalty: 2.0,
        presence_penalty: 0.0,
        temperature: 2.0,
        logprobs: true
      }
    end

    def model
      RESOURCE_MODEL
    end

    def word?(token)
      token =~ /\A[a-zA-Z0-9]+\z/
    end

    def not_json_schema_key?(token)
      schema_keys = chat_completion_attrs.dig(:response_format, :json_schema, :schema, :required)
      schema_keys.exclude?(token)
    end
  end
end
