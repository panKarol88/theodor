# frozen_string_literal: true

module Rupert
  module V1
    class API < Rupert::API
      version 'v1', using: :header, vendor: 'rupert'
      format :json

      before do
        authenticate_user! unless skip_authentication?
      end

      rescue_from :all do |exception|
        handle_exception(exception)
      end

      helpers ::Rupert::Helpers::Auth
      helpers ::Rupert::Helpers::ErrorHandler

      helpers do
        def permitted_params
          declared(params, include_missing: false).deep_symbolize_keys
        end
      end

      mount Users::API
      mount Prompts::API
      mount Karollama::API
    end
  end
end
