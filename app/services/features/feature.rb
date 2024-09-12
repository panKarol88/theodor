# frozen_string_literal: true

module Features
  class Feature
    include ::Helpers::LlmInterface
    include ::Helpers::PromptDecoratorsInterface

    def initialize(feature_record:, thread_object:, user:, feature_properties: {})
      @feature_record = feature_record
      @thread_object = thread_object.deep_symbolize_keys
      @user = user
      @feature_properties = feature_properties.deep_symbolize_keys
    end

    def process
      thread_object[:output] = obtain_response
      create_thread_log

      if feature_record.store_results?
        DataCrumbs::Builder.new(content: thread_object[:output], warehouse:).embed_and_create
        thread_object[:output] = "The information has been successfully stored in the #{warehouse.name} warehouse."
      end

      thread_object
    end

    private

    attr_reader :feature_record, :thread_object, :user, :feature_properties

    def obtain_response
      chat(prompt)
    end

    def create_thread_log
      thread_object[:thread_log] << {
        feature_id: feature_record.id,
        feature_name: feature_record.name,
        feature_properties:,
        input: prompt,
        output: thread_object[:output],
        thread_object: thread_object.except(:thread_log, :input, :output)
      }
    end

    def warehouse
      warehouse_id = feature_properties[:warehouse_id] || thread_object[:warehouse_id]

      user.warehouses.find(warehouse_id) if warehouse_id
    end

    def prompt
      @prompt ||= prompt_decorators.map do |prompt_decorator|
        parse_prompt_decorator(prompt_decorator:, input: thread_object[:input])
      end.join("\n")
    end

    def prompt_decorators
      @prompt_decorators ||= feature_record.prompt_decorators.priority_ordered
    end
  end
end
