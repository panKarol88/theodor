# frozen_string_literal: true

module Langfuse
  class Client
    include Utils::LangfuseInterface

    MODEL = 'gpt-4o-mini'
    DEFAULT_FUNNEL = 'default'

    attr_reader :session_id, :trace_id, :generation_id, :decorated_prompt

    # :reek:LongParameterList
    def initialize(original_message:, session_id: nil, model: MODEL, funnel: DEFAULT_FUNNEL)
      @original_message = original_message
      @session_id = session_id
      @model = model
      @funnel = funnel
    end

    def process_with_langfuse(prompt_name:, variables:)
      @prompt_name = prompt_name
      @decorated_prompt = generate_decorated_prompt(variables:)

      session_id.present? ? generation_create : invoke
      raw_response, response = yield
      generation_update(output: raw_response)
      response
    end

    # build decorated promp
    # input:
    # Exmple text and this is some content {{content}}
    # output:
    # Exmple text and this is some content Example Content
    # :reek:NestedIterators, :reek:FeatureEnvy
    def generate_decorated_prompt(variables:)
      prompt['prompt'].map do |prompt_message|
        content = prompt_message['content'].gsub(/\{\{(\w+)\}\}/) do |match|
          variable = match.gsub(/\{\{(.*)\}\}/, '\1').to_sym
          variables[variable] || match
        end

        { role: prompt_message['role'], content: }
      end
    end

    private

    attr_reader :original_message, :prompt_name, :model, :funnel

    def invoke
      @session_id ||= generate_uuid
      @trace_id = generate_uuid
      @generation_id = generate_uuid
      ingestion_request(instructions: [trace_create_body, generation_create_body])
    end

    def generation_create
      @generation_id = generate_uuid
      ingestion_request(instructions: [generation_create_body])
    end

    def generation_update(output:)
      ingestion_request(instructions: [generation_update_body(output:)])
    end

    def trace_create_body
      {
        id: SecureRandom.uuid,
        timestamp: time_now,
        type: 'trace-create',
        body: { id: trace_id,
                timestamp: time_now,
                sessionId: session_id,
                name: funnel,
                input: original_message,
                public: false }
      }
    end

    def generation_create_body
      {
        id: SecureRandom.uuid,
        type: 'generation-create',
        timestamp: time_now,
        body: { id: generation_id,
                traceId: trace_id,
                timestamp: time_now,
                promptName: prompt_name,
                promptVersion: 1,
                input: decorated_prompt.to_json,
                type: 'GENERATION',
                name: prompt_name,
                model: }
      }
    end

    def generation_update_body(output:)
      {
        id: SecureRandom.uuid,
        type: 'generation-update',
        timestamp: time_now,
        body: {
          id: generation_id,
          traceId: trace_id,
          timestamp: time_now,
          endTime: time_now,
          output:
        }
      }
    end

    def ingestion_url
      URI("#{api_url}/public/ingestion")
    end

    def time_now
      Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
    end

    def prompt
      langfuse_request(url: URI("#{api_url}/public/v2/prompts/#{prompt_name}"))
    end

    def ingestion_request(instructions:, url: ingestion_url, method: 'Post')
      body = { batch: instructions }.to_json

      response = langfuse_request(url:, body:, method:)
      Rails.logger.info("Langfuse response: #{response}")
    end
  end
end
