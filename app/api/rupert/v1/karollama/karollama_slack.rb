# frozen_string_literal: true

module Rupert
  module V1
    module Karollama
      class KarollamaSlack < API
        desc 'Process karollama with slack.'

        SLACK_SESSION_ID = 'ongoing_karollama_slack_session'
        SLACK_WAREHOUSE_NAME = 'karollama'

        params do
          optional :challenge, type: String, desc: 'Challenge'
          optional :team_id, type: String, desc: 'Team ID'
          optional :event, type: Hash, desc: 'Event'
        end

        helpers do
          def slack_team_id
            permitted_params[:team_id]
          end

          def event_user_id
            permitted_params[:event][:user]
          end

          def message
            permitted_params[:event][:blocks].first[:elements].first[:elements].first[:text]
          end

          def should_ask_karollama?
            slack_team_id == ENV.fetch('SLACK_TEAM_ID') &&
              event_user_id != ENV.fetch('SLACK_RUPERT_USER_ID') &&
              permitted_params[:challenge].blank?
          end

          def result
            @result ||= ::Karollama::MessageHandler.new(
              session_id: SLACK_SESSION_ID,
              warehouse_name: SLACK_WAREHOUSE_NAME
            ).process_message(message:)
          end

          def send_karollama_slack_message
            Slack::Client.new.send_karollama_message(result[:response])
          end
        end

        post do
          Thread.new { send_karollama_slack_message } if should_ask_karollama?

          return permitted_params[:challenge] if permitted_params[:challenge].present?

          status :ok
        end

        get do
          permitted_params[:challenge]
        end
      end
    end
  end
end
