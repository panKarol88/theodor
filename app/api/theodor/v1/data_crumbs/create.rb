# frozen_string_literal: true

module Theodor
  module V1
    module DataCrumbs
      class Create < API
        desc 'Create Data Crumbs.'

        params do
          requires :content, type: String, desc: 'Content of the Data Crumb.'
          optional :warehouse_id, type: Integer, desc: 'ID of the Warehouse.'
          optional :warehouse_name, type: String, desc: 'Name of the Warehouse.'
          optional :feature_id, type: Integer, desc: 'ID of the Feature.'
          optional :feature_name, type: String, desc: 'Name of the Feature.'
        end

        helpers do
          def input
            @input ||= params[:content]
          end

          def warehouse
            @warehouse ||= begin
              warehouse_attrs = { id: params[:warehouse_id], name: params[:warehouse_name] }.compact
              Warehouse.find_by(warehouse_attrs)
            end
          end

          def feature
            @feature ||= begin
              feature_attrs = { id: params[:feature_id], name: params[:feature_name] }.compact
              Feature.find_by(feature_attrs)
            end
          end
        end

        post do
          data_crumb = ::DataCrumbs::Builder.new(input:, warehouse:, feature:).prepare_input.embed_and_create!

          present data_crumb, with: API::Theodor::Entities::DataCrumb::Create
        end
      end
    end
  end
end
