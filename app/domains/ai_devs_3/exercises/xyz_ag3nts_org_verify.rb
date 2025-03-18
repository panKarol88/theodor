# S01E02 - Zadanie 1
#
# https://xyz.ag3nts.org/files/0_13_4b.txt - Oprogramowanie robota patrolującego

module AiDevs3
  module Exercises
    class XyzAg3ntsOrgVerify < Exercise
      attr_reader :msg_id, :text, :verify_link

      def data_source
        URI.open(data_link).readlines(chomp: true)
      end

      def handshake
        @verify_link = 'https://xyz.ag3nts.org/verify'
        response = JSON.parse(send_post_request(verify_link, { text: 'READY', msgID: '0' }.to_json ))
        p response

        @msg_id = response['msgID']
        @text = response['text']
      end

      def verify_answer(question)
        p question

        chat_message = 'Based on the following context:\n'
        chat_message += "## CONTEXT ##\n #{data_source} ######\n"
        chat_message += 'Answer the following question:\n'
        chat_message += "## QUESTION ## #{question} ######\n"
        answer_payload = chat(chat_message)
        p answer_payload

        answer_payload[:content]
      end

      def verify
        handshake

        p JSON.parse(send_post_request(verify_link, { text: verify_answer(text), msgID: msg_id }.to_json ))
      end
    end
  end
end

# AiDevs3::Exercises::XyzAg3ntsOrgVerify.new(data_link: 'https://xyz.ag3nts.org/files/0_13_4b.txt').verify
