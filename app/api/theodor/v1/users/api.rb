# frozen_string_literal: true

module Theodor
  module V1
    module Users
      class API < Theodor::V1::API
        resource :users do
          mount Theodor::V1::Users::SignIn
        end
      end
    end
  end
end
