# frozen_string_literal: true

module Theodor
  module V1
    module DataCrumbs
      class API < Theodor::V1::API
        resource :data_crumbs do
          mount Theodor::V1::DataCrumbs::Index
          mount Theodor::V1::DataCrumbs::Create
        end
      end
    end
  end
end
