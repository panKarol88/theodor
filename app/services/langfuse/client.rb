# frozen_string_literal: true

module Langfuse
  class Client
    include Utils::LangfuseInterface
    include Helpers::LlmInterface

    MODEL = 'gpt-4o-mini'
    DEFAULT_FUNNEL = 'default'

    attr_reader :session_id, :trace_id, :generation_id

    # :reek:LongParameterList
    def initialize(funnel: DEFAULT_FUNNEL, session_id: nil, model: MODEL)
      @session_id = session_id || generate_uuid
      @model = model
      @funnel = funnel
      @instructions = []
    end

    def process_message(message:, prompt_name:, variables:)
      trace_create(message:) if trace_id.blank?

      decorated_prompt = generate_decorated_prompt(prompt_name:, variables:)
      generation_id = generation_create(prompt_name:, decorated_prompt:)
      raw_response = chat(prompt: decorated_prompt, model:)
      response = parsed_chat_response(raw_response)

      generation_update(generation_id:, raw_response:)

      response
    end

    def finalize_processing(response:)
      instructions[0][:body][:output] = response

      ingestion_request(instructions:)
    end

    private

    attr_reader :model, :funnel, :instructions

    # build decorated promp
    # input:
    # Exmple text and this is some content {{content}}
    # output:
    # Exmple text and this is some content Example Content
    # :reek:NestedIterators, :reek:FeatureEnvy
    def generate_decorated_prompt(prompt_name:, variables:)
      prompt(prompt_name:)['prompt'].map do |prompt_message|
        content = prompt_message['content'].gsub(/\{\{(\w+)\}\}/) do |match|
          variable = match.gsub(/\{\{(.*)\}\}/, '\1').to_sym
          variables[variable] || match
        end

        { role: prompt_message['role'], content: }
      end
    end

    def trace_create(message:)
      @trace_id = generate_uuid

      instructions << {
        id: SecureRandom.uuid,
        timestamp: time_now,
        type: 'trace-create',
        body: { id: trace_id,
                timestamp: time_now,
                sessionId: session_id,
                name: funnel,
                input: message,
                output: '',
                public: false }
      }

      trace_id
    end

    def generation_create(prompt_name:, decorated_prompt:)
      generation_id = generate_uuid

      instructions << {
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

      generation_id
    end

    def generation_update(generation_id:, raw_response:)
      instructions << {
        id: SecureRandom.uuid,
        type: 'generation-update',
        timestamp: time_now,
        body: {
          id: generation_id,
          traceId: trace_id,
          timestamp: time_now,
          endTime: time_now,
          output: raw_response
        }
      }
    end

    def span_create(start_time:, name:, output:)
      instructions << {
        id: SecureRandom.uuid,
        type: 'span-create',
        timestamp: time_now,
        body: {
          id: generate_uuid,
          traceId: trace_id,
          timestamp: time_now,
          startTime: start_time,
          endTime: time_now,
          name:,
          input: name,
          output:,
          public: false
        }
      }
    end

    def time_now
      Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
    end

    def prompt(prompt_name:)
      start_time = time_now
      langfuse_prompt = langfuse_request(url: URI("#{api_url}/public/v2/prompts/#{prompt_name}"))
      span_create(start_time:, name: prompt_name, output: langfuse_prompt)

      langfuse_prompt
    end

    def ingestion_request(instructions:, method: 'Post')
      url = URI("#{api_url}/public/ingestion")
      body = { batch: instructions }.to_json

      response = langfuse_request(url:, body:, method:)
      Rails.logger.info("Langfuse response: #{response}")
    end
  end
end
