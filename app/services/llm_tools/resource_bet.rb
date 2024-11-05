# frozen_string_literal: true

module LlmTools
  class ResourceBet
    RESOURCE_MODEL = 'gpt-4o-2024-08-06'

    def submit(prompt:)
      OpenAi::Client.new.chat_completion(prompt:, model:, chat_completion_attrs:)['choices'][0]
    end

    private

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
        temperature: 2.0
      }
    end

    def model
      RESOURCE_MODEL
    end
  end
end
