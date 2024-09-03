# frozen_string_literal: true

class WorkflowsController < ApplicationController
  before_action :set_workflow

  def show
    @features = @workflow.features.priority_ordered
  end

  def new_feature
    @feature = Feature.new
  end

  def show_feature
    @feature = current_features.find(params[:feature_id])
  end

  def create_feature
    feature_id = params[:feature_id]
    Features::WorkflowHandler.new(workflow: @workflow, feature_id:, **feature_params).assign_feature

    respond_to do |format|
      format.turbo_stream
    end
  end

  def delete_workflows_feature
    @workflow.workflows_features.find(params[:workflows_feature_id]).destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def process_input
    @input_text = process_input_params[:input_text]
  end

  private

  def process_input_params
    params.permit(:input_text)
  end

  def feature_params
    params.permit(:resource_class)
  end

  def set_workflow
    workflow_id = params[:id]
    @workflow = current_user.workflows.find(workflow_id) if workflow_id.present?
  end
end
