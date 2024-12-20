# frozen_string_literal: true

module Features
  class ResourceFeature < Feature
    RESOURCE_FEATURE_NAME = 'resource_feature'

    def initialize(feature_record:, thread_object:, user:, feature_properties: {})
      super

      set_resource_collection
    end

    private

    attr_reader :resource_collection

    def obtain_response
      response_object = resource_bet(prompt)
      content, probability = JSON.parse(response_object[:content]), response_object[:probability]
      resource_id = resource_class.find_by(name: content['resource'])&.id

      thread_object[:initial_response] = response_object
      thread_object[:"#{resource_class.to_s.downcase}_id"] = resource_id

      Shared::AnswerGenerator.new(content:, probability:, probability_threshold:).generate_answer
    end

    def set_resource_collection
      return if resource_class.blank?

      @resource_collection = resource_class.restricted_by(user:)
    end

    def feature_record
      @feature_record ||= ::Feature.find_by(name: RESOURCE_FEATURE_NAME)
    end

    def resource_class
      feature_properties[:resource_class]&.constantize
    end
  end
end
