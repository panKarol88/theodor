# frozen_string_literal: true

module Rupert
  module V1
    module Karollama
      class Karollama < API
        desc 'Process karollama.'

        params do
          requires :message, type: String, desc: 'Message'
          optional :session_id, type: String, desc: 'Session ID'
          optional :debug, type: Boolean, desc: 'Debug'
        end

        helpers do
          def karollama_handler
            @karollama_handler ||= ::Karollama::MessageHandler.new(session_id: params[:session_id], debug: params[:debug])
          end

          def result
            @result ||= karollama_handler.process_message(message: params[:message])
          end
        end

        post do
          {
            answer: result[:response],
            session_id: result[:session_id]
          }
        end
      end
    end
  end
end
