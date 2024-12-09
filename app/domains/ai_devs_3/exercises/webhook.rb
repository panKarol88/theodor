# S04E04 - Zadanie 1

module AiDevs3
  module Exercises
    class Webhook < Exercise
      def answer
        'https://fb9f-46-112-86-17.ngrok-free.app/api/ai_devs/webhook'
      end

      def get_instructions(input)
        messages = [
          {
            'role': 'system',
            'content': AiDevs3::Exercises::Prompts::Webhooks::AnswerNotesQuestions.new.prompt,
          },
          {
            'role': 'user',
            'content': input,
          },
        ]

        chat_response = OpenAi::Client.new.chat_completion(prompt: messages)
        response = chat_response['choices'][0]['message']['content']
        JSON.parse(response.gsub(/=>/, ':'))['coordination_code']
      rescue NoMethodError => e
        Rails.logger.error(chat_response)
        raise e
      end

      def get_new_position(current_position: '[0][0]', coordinate_code:)
        content = {
          current_position: ,
          coordinate_code: coordinate_code
        }.to_json

        messages = [
          {
            'role': 'system',
            'content': AiDevs3::Exercises::Prompts::Webhooks::MapDescription.new.prompt,
          },
          {
            'role': 'user',
            'content': content,
          },
        ]

        chat_response = OpenAi::Client.new.chat_completion(prompt: messages)
        response = chat_response['choices'][0]['message']['content']
        json_response = JSON.parse(response.gsub(/=>/, ':'))

        { current_position: json_response['current_position'], description: json_response['current_position_description'] }
      rescue NoMethodError => e
        Rails.logger.error(chat_response)
        raise e
      end

      def move_based_on_request(current_position: '[0][0]', request:)
        coordinate_code = get_instructions(request)
        get_new_position(current_position:, coordinate_code:)
      end
    end
  end
end

# AiDevs3::Exercises::Webhook.new(destination_link: 'https://centrala.ag3nts.org/report', task: 'WEBHOOK').send_answer
# AiDevs3::Exercises::Webhook.new(destination_link: 'https://centrala.ag3nts.org/report', task: 'WEBHOOK').get_instructions('dawaj w prawo')
# AiDevs3::Exercises::Webhook.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'WEBHOOK'
# ).move_based_on_request(current_position: '[0][0]', request: 'dej w prawo')
