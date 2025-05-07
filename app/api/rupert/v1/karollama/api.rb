# frozen_string_literal: true

module Rupert
  module V1
    module Karollama
      class API < Rupert::V1::API
        route_setting :auth, disabled: true

        resource :karollama do
          mount Rupert::V1::Karollama::Karollama
        end

        resource :karollama_slack do
          mount Rupert::V1::Karollama::KarollamaSlack
        end
      end
    end
  end
end
