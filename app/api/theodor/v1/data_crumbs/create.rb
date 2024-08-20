# frozen_string_literal: true

module Theodor
  module V1
    module DataCrumbs
      class Create < API
        desc 'Create Data Crumbs.'

        params do
          requires :content, type: String, desc: 'Content of the Data Crumb.'
        end

        helpers do
          def input
            @input ||= params[:content]
          end
        end

        post do
          data_crumb = Features::Feature.new(feature_record: feature, input:, warehouse:).process

          present data_crumb, with: API::Theodor::Entities::DataCrumb::DataCrumb
        end
      end
    end
  end
end
