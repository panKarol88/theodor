# frozen_string_literal: true

module Rupert
  module V1
    module Users
      class API < Rupert::V1::API
        resource :users do
          mount Rupert::V1::Users::SignIn
        end
      end
    end
  end
end
