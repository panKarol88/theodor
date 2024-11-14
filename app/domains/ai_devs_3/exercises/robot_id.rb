# S02E03 - Zadanie 1

module AiDevs3
  module Exercises
    class RobotId < Exercise
      def description
        response = URI.open("https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY', nil)}/robotid.json").readlines(chomp: true)
        JSON.parse(response.join)['description']
      end

      def image_prompt
        message = 'Wydobądź z tego tekstu wyłącznie opis robota lub postaci.'
        message += 'Przygotuj na ich podstawie prompt dla modelu generowania obrazów. Zwróc jedynie ten prompt i nic więcej.\n'
        message += "<tekst>#{description}</tekst>"

        chat(message)[:content]
      end

      def answer
        p "Original description: #{description}"
        p "Image Prompt: #{image_prompt}"

        result = image_generation(image_prompt)['data'][0]['url']
        p result

        result
      end
    end
  end
end

# AiDevs3::Exercises::RobotId.new.answer

# AiDevs3::Exercises::RobotId.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'ROBOTID'
# ).send_answer
