# frozen_string_literal: true

module Theodor
  module Helpers
    module Auth
      def current_user
        return @current_user if defined?(@current_user)

        @current_user ||= skip_authentication? ? user_from_params : warden.authenticate(:jwt, scope: :user, run_callbacks: false)
      end

      def authenticate_user!
        raise unauthorized_error! unless current_user
      end

      def unauthorized_error!
        raise_api_error!('Unauthorized', :unauthorized)
      end

      def skip_authentication?
        route.settings&.dig(:auth, :disabled)
      end

      def access_token(sub: current_user.id)
        Warden::JWTAuth::TokenEncoder.new.call({ sub:, scp: 'user' }.with_indifferent_access)
      end

      private

      def warden
        request.env['warden']
      end
    end
  end
end
