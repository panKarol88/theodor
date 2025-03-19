# frozen_string_literal: true

module Theodor
  module V1
    module Karollama
      class API < Theodor::V1::API
        route_setting :auth, disabled: true

        resource :karollama do
          mount Theodor::V1::Karollama::Karollama
        end
      end
    end
  end
end
