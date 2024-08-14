# frozen_string_literal: true

module AiFeatures
  class Knowledge
    include Helpers::LlmInterface

    def initialize(input:, warehouse: nil, feature: nil)
      @input = input
      @warehouse = warehouse
      @feature = feature

      post_initialize
    end

    def process
      feature.process(input, warehouse)
    end

    private

    attr_reader :input, :warehouse, :feature

    def post_initialize
      @warehouse ||= warehouse_based_on_input
      @post_initialize ||= feature_based_on_input
    end

    def warehouse_based_on_input
      # in future when warehouse is not provided, model will figure it out on its own
      # till then - raise an error
      raise 'Warehouse is required'
    end

    def feature_based_on_input
      # in future when feature is not provided, model will figure it out on its own
      # till then - raise an error
      raise 'Feature is required'
    end
  end
end
