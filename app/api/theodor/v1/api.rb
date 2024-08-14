# frozen_string_literal: true

module Theodor
  module V1
    class API < Theodor::API
      version 'v1', using: :header, vendor: 'theodor'
      format :json

      before do
        authenticate_user! unless skip_authentication?
      end

      rescue_from :all do |exception|
        handle_exception(exception)
      end

      helpers ::Theodor::Helpers::Auth
      helpers ::Theodor::Helpers::ErrorHandler

      mount Users::API
      mount DataCrumbs::API
      mount Prompts::API
    end
  end
end
