# frozen_string_literal: true

module AiFeatures
  class Knowledge
    include Helpers::LlmInterface

    def initialize(input:, user:, warehouse: nil, feature: nil)
      @input = input
      @user = user
      @warehouse = warehouse
      @feature = feature

      post_initialize
    end

    def process
      feature.process(input:, warehouse:)
    end

    private

    attr_reader :input, :user, :warehouse, :feature

    def post_initialize
      @warehouse ||= warehouse_based_on_input
      @post_initialize ||= feature_based_on_input
    end

    def warehouse_based_on_input
      Features::ResourceFeature.new(input:, resource_collection: user.warehouses).process
    end

    def feature_based_on_input
      Features::ResourceFeature.new(input:, resource_collection: warehouse.features).process
    end
  end
end
