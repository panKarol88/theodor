# frozen_string_literal: true

module Features
  class ResourceFeature < Feature
    RESOURCE_FEATURE_NAME = 'resource_feature'

    def initialize(input:, resource_collection:)
      super(feature_record:, input:, warehouse:)

      @resource_collection = resource_collection
    end

    def process
      resource_class.find_by(name: resource_bet(prompt)[:resource])
    end

    private

    attr_reader :resource_collection

    def feature_record
      @feature_record ||= ::Feature.find_by(name: RESOURCE_FEATURE_NAME)
    end

    def resource_class
      @resource_class ||= resource_collection.first.class
    end
  end
end
