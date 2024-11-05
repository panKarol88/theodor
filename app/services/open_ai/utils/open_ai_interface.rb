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

      def default_chat_completion_attrs
        {
          frequency_penalty: 0.2, # [float] between -2.0 and 2.0.
          logit_bias: nil, # [object]
          logprobs: true, # [boolean] return log probabilities
          top_logprobs: nil, # [integer] between 0 and 20 specifying the number of most likely tokens for each token position
          max_tokens: 3000, # [integer] between 1 and 4096
          n: 1, # [integer] how many chat completion choices to generate
          presence_penalty: 0.2, # [float] between -2.0 and 2.0
          response_format: { type: 'text' }, # [object] { type: 'json_object' } or { type: 'text' } or { type: 'json_schema', json_schema: { ... } }
          seed: nil, # [integer] seed for random number generation
          service_tier: nil,
          stop: nil, # [string / array] up to 4 sequences where the API will stop generating further tokens
          stream: false, # [boolean] whether to stream the response
          stream_options: nil, # [object] options for streaming
          temperature: nil, # [float] between 0.0 and 2.0
          top_p: 0.1, # [float] between 0.0 and 1.0;  0.1 means only the tokens comprising the top 10% probability mass are considered
          tools: nil, # [array] list of tools to enable (like calling functions)
          tool_choice: nil, # [string / object] choice of tools to enable
          parallel_tool_calls: nil, # [boolean] whether to call tools in parallel
          user: nil # [string] user ID
        }
      end
    end
  end
end
