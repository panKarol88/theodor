# frozen_string_literal: true

module Rupert
  module V1
    module Users
      class SignIn < API
        resource :sign_in do
          route_setting :auth, disabled: true
          desc 'Sign in',
               success: {
                 code: 200, message: '{ access_token: jwt_token}'
               },
               failure: [
                 { code: 400, message: 'Bad request' },
                 { code: 404, message: 'Email or password is invalid' },
                 { code: 422, message: 'Unprocessable entity' }
               ]

          params do
            requires :email, type: String, desc: 'Email'
            requires :password, type: String, desc: 'Password'
          end

          helpers do
            def user_from_params
              User.find_by(email: params[:email])
            end
          end

          post do
            raise_api_error!('Email or password is invalid', :not_found) unless user_from_params&.valid_password?(params[:password])

            header 'Authorization', "Bearer #{access_token}"

            status :ok
            { access_token: }
          end
        end
      end
    end
  end
end
