# frozen_string_literal: true

module Features
  class WorkflowHandler
    def initialize(workflow:, feature_id:, **feature_args)
      @workflow = workflow
      @feature_id = feature_id
      @feature_args = feature_args
    end

    def assign_feature
      workflow.workflows_features.create!(feature_id:, properties: feature_args, priority: workflow.features.count)
    end

    private

    attr_reader :workflow, :feature_id, :feature_args
  end
end
