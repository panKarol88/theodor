# frozen_string_literal: true

module Theodor
  module V1
    module Karollama
      class Karollama < API
        desc 'Process karollama.'

        params do
          requires :message, type: String, desc: 'Message'
        end

        helpers do
          def karollama_handler
            @karollama_handler ||= ::Karollama::MessageHandler.new(message: params[:message])
          end
        end

        post do
          {
            answer: karollama_handler.process_message
          }
        end
      end
    end
  end
end
