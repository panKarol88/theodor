# frozen_string_literal: true

module Workflows
  class WorkflowHandler
    def initialize(workflow:)
      @workflow = workflow
      @user = workflow.user
      @thread_object = { thread_log: [], stop_processing: false }
    end

    # TODO: Refactor
    def process_input(input:, **workflow_args) # rubocop:disable Metrics/AbcSize
      thread_object.merge!(input:, **workflow_args)

      workflow.workflows_features.includes(feature: :prompt_decorators).priority_ordered.each do |workflows_feature|
        feature_properties = workflows_feature.properties
        feature_results = workflows_feature.feature.process(thread_object:, user:, feature_properties:)
        thread_object.merge!(feature_results)

        break if stop_processing?
      end

      final_feature = Feature.find(thread_object[:feature_id])

      if final_feature.present? && !stop_processing?
        final_feature_results = final_feature.process(thread_object:, user:)
        thread_object.merge!(final_feature_results)
      end

      thread_object
    end

    def assign_feature(feature_id:, **feature_args)
      workflow.workflows_features.create!(feature_id:, properties: feature_args, priority: workflow.features.count)
    end

    private

    attr_reader :workflow, :user, :thread_object

    def stop_processing?
      thread_object[:stop_processing] == true
    end
  end
end
