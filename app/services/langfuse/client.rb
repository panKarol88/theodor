# frozen_string_literal: true

module Langfuse
  class Client
    include Utils::LangfuseInterface

    MODEL = 'gpt-4o-mini'
    DEFAULT_FUNNEL = 'default'

    # :reek:LongParameterList
    def initialize(prompt_name:, variables: {}, session_id: nil, trace_id: nil, generation_id: nil, model: MODEL, funnel: DEFAULT_FUNNEL)
      @prompt_name = prompt_name
      @variables = variables
      @session_id = session_id || generate_uuid
      @trace_id = trace_id || generate_uuid
      @generation_id = generation_id || generate_uuid
      @model = model
      @funnel = funnel
    end

    # build final promp
    # input:
    # Exmple text and this is some content {{content}}
    # output:
    # Exmple text and this is some content Example Content
    # :reek:NestedIterators
    def final_prompt
      @final_prompt ||= prompt['prompt'].map do |message|
        content = message['content'].gsub(/\{\{(\w+)\}\}/) do |match|
          variable = match.gsub(/\{\{(.*)\}\}/, '\1').to_sym
          variables[variable] || match
        end

        { role: message['role'], content: }
      end
    end

    def process_with_langfuse
      invoke
      raw_response, response = yield
      generation_update(output: raw_response)

      response
    end

    def invoke
      ingestion_request(instructions: [trace_create_body, generation_create_body])
    end

    def trace_create
      ingestion_request(instructions: [trace_create_body])
    end

    def generation_create
      ingestion_request(instructions: [generation_create_body])
    end

    def generation_update(output:)
      ingestion_request(instructions: [generation_update_body(output:)])
    end

    private

    attr_reader :prompt_name, :variables, :session_id, :trace_id, :generation_id, :model

    def trace
      langfuse_request(url: URI("#{api_url}/public/traces/#{trace_id}"))
    end

    def trace_create_body
      {
        id: SecureRandom.uuid,
        timestamp: time_now,
        type: 'trace-create',
        body: { id: trace_id,
                timestamp: time_now,
                sessionId: session_id,
                name: 'My Trace',
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
                input: final_prompt.to_json,
                type: 'GENERATION',
                name: 'generation-karollama',
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

      response
    end
  end
end
