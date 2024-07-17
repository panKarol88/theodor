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
          optional :edit_input_strategy_name, type: String, desc: 'Edit input strategy name.'

          exactly_one_of(:warehouse_id, :warehouse_name)
        end

        helpers do
          def input
            @input ||= params[:content]
          end

          def warehouse
            @warehouse ||= Warehouse.find_by(id: params[:warehouse_id]) || Warehouse.find_by(name: params[:warehouse_name])
          end
        end

        post do
          raise_api_error!('Warehouse not found', :not_found) if warehouse.blank?

          data_crumb = ::DataCrumbs::Builder.new(input:, warehouse:).prepare_input.embed_and_create!

          present data_crumb, with: API::Theodor::Entities::DataCrumb::Create
        end
      end
    end
  end
end
