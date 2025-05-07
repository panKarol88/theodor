module Slack
  class Client
    def send_karollama_message(text)
      channel = ENV.fetch('SLACK_KAROLLAMA_CHANNEL_ID')
      client.chat_postMessage(channel:, text:)
    end

    private

    def client
      @client ||= Slack::Web::Client.new
    end
  end
end
