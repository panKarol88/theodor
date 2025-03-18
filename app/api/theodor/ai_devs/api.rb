# frozen_string_literal: true

module Theodor
  module AiDevs
    class API < Theodor::API
      format :json

      rescue_from :all do |exception|
        handle_exception(exception)
      end

      helpers ::Theodor::Helpers::ErrorHandler

      resource :webhook do

        post do
          status :ok

          current_position = AiDevs3::Exercises::Webhook.new(
            destination_link: 'https://centrala.ag3nts.org/report',
            task: 'WEBHOOK'
          ).move_based_on_request(current_position: '[0][0]', request: params['instruction'])

          Rails.logger.info('**********************')
          Rails.logger.info(params['instruction'])
          Rails.logger.info('**********************')
          Rails.logger.info(current_position)
          Rails.logger.info('**********************')
          Rails.logger.info({ 'description': current_position[:description] })
          Rails.logger.info('**********************')

          { 'description': current_position[:description] }
        end
      end
    end
  end
end
