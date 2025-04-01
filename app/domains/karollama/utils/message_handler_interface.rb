module Karollama
  module Utils
    module MessageHandlerInterface
      def parsed_chat_response(chat_response)
        JSON.parse(chat_response[:content])['answer']
      end
    end
  end
end
