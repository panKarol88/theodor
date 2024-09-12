# frozen_string_literal: true

module Theodor
  module Helpers
    module PromptAPI
      extend Grape::API::Helpers

      params :knowledge_api do
        requires :input, type: String, desc: 'Input of the prompt.'
        optional :warehouse_id, type: Integer, desc: 'ID of the Warehouse.'
        optional :warehouse_name, type: String, desc: 'Name of the Warehouse.'
        optional :feature_id, type: Integer, desc: 'ID of the Feature.'
        optional :feature_name, type: String, desc: 'Name of the Feature.'
        optional :workflow_id, type: Integer, desc: 'ID of the Workflow.'
        optional :workflow_name, type: String, desc: 'Name of the Workflow.'
      end

      def input
        @input ||= params[:input]
      end

      def warehouse
        @warehouse ||= begin
          warehouse_attrs = { id: params[:warehouse_id], name: params[:warehouse_name] }.compact
          warehouse_attrs.empty? ? nil : Warehouse.find_by(warehouse_attrs)
        end
      end

      def feature
        @feature ||= begin
          feature_attrs = { id: params[:feature_id], name: params[:feature_name] }.compact
          feature_attrs.empty? ? nil : Feature.find_by(feature_attrs)
        end
      end

      def workflow
        @workflow ||= begin
          workflow_attrs = { id: params[:workflow_id], name: params[:workflow_name] }.compact
          workflow_attrs.empty? ? nil : Workflow.find_by(workflow_attrs)
        end
      end
    end
  end
end
