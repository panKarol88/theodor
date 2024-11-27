# S04E01 - Zadanie 1

module AiDevs3
  module Exercises
    class Interfejs < Exercise
      def initialize(data_link: nil, destination_link: nil, task: nil)
        super(data_link: data_link, destination_link: destination_link, task: task)

        @photo1 = 'IMG_559.PNG'
        @photo2 = 'IMG_1410.PNG'
        @photo3 = 'IMG_1443.PNG'
      end

      def start
        payload = {
          'task': 'photos',
          'apikey': ENV.fetch('AI_DEVS_API_KEY'),
          'answer': 'START'
        }.to_json

        HttpRequestsHelper::Requester.new(url: destination_link, payload:).post
      end

      def flag(prompt)
        send_photo_request { prompt }
      end

      def repair(image_name)
        send_photo_request { "REPAIR #{image_name}" }
      end

      def darken(image_name)
        send_photo_request { "DARKEN #{image_name}" }
      end

      def brighten(image_name)
        send_photo_request { "BRIGHTEN #{image_name}" }
      end

      def process_photo(photo_url)
        vision_sources = [photo_url]

        prompt = "From now on, you will act as a Personal Graphics Assistant, specialized in processing photographies. Your primary function is to interpret photography of people and provide a detailed description of those people in a structured JSON response. Here are your guidelines:

<prompt_objective>
Interpret photography of a person and generate a JSON object (without markdown block) containing a detailed description of a person, without directly responding to user queries.
If there are some difficulties with the photo (it is too dark or too bright or damaged), generate a JSON object what action is required to fix the photo.
</prompt_objective>

<response_format>
{
  '_thinking': 'explanation of your interpretation and decision process',
  'description': 'a detailed description of the person in the photo or empty if the photo is too dark or too bright or damaged',
  'action': 'REPAIR' OR 'DARKEN' OR 'BRIGHTEN' OR empty
}
</response_format>

<prompt_rules>
- Always analyze photos to generate a description of a person or suggest an action
- Never engage in direct conversation or task management advice
- Output only the specified JSON format
- Include a '_thinking' field to explain your interpretation process
- Use only the provided photo
</prompt_rules>

<output_format>
Always respond with this JSON structure:
{
  '_thinking': 'explanation of your interpretation and decision process',
  'description': 'detailed description of the person OR empty',
  'action': 'REPAIR' OR 'DARKEN' OR 'BRIGHTEN' OR empty
}
</output_format>

<prompt_examples>
Example 1: The photo is corrupted

Your output:
{
  '_thinking': 'It looks like it might be hard to recognize the person on this photo due to some corruption.',
  'description': '',
  'action': 'REPAIR'
}

Example 2: The photo is too dark

Your output:
{
  '_thinking': 'It looks like it there is not enough light in the photo to recognize the person.',
  'description': '',
  'action': 'BRIGHTEN'
}

Example 3: The photo is too bright

Your output:
{
  '_thinking': 'It looks like it there is too much light in the photo to recognize the person.',
  'description': '',
  'action': 'DARKEN'
}

Example 4: Photo is good enough to fully describe the person

Your output:
{
  '_thinking': 'Ok, I dont see any issues with this photo. It is just enough light to recognize the person.',
  'description': 'The individual is described as having a medium complexion with brown skin. They are wearing glasses with a thin metal frame. The subject has short, dark brown hair, neatly groomed. They are dressed in a green sweater of standard fit and dark-colored trousers. On their feet, they are wearing black leather boots with visible laces. The individual is also noted to be wearing a silver wristwatch on their left hand and a simple gold ring on the ring finger of their right hand.',
  'action': ''
}
</prompt_examples>

Remember, your sole function is to generate these JSON responses based on the photo provided. Do not engage in task management advice or direct responses to queries."

        JSON.parse(vision_info(prompt, vision_sources)[:content])

      rescue JSON::ParserError
        {
          'description': '',
          'action': ''
        }
      end

      def getting_answer
        dirty = true

        while dirty
          dirty = false

          [photo1, photo2, photo3].each.with_index(1) do |photo, index|
            p [photo1, photo2, photo3]
            photo_url = "https://centrala.ag3nts.org/dane/barbara/#{photo}"

            next if photo.split(' - ').size > 1

            result = process_photo(photo_url)
            p result

            if result['description'].present?
              self.send("photo#{index}=", "#{photo} - #{result['description']}")
              next
            end

            dirty = true

            if result['action'].present?
              response = case result['action']
                         when 'REPAIR'
                           repair(photo)
                         when 'DARKEN'
                           darken(photo)
                         when 'BRIGHTEN'
                           brighten(photo)
                         else
                           next
                         end

              p response
              new_file_name = response.match(/[\w\-]+\.(png|jpg|jpeg|gif)/i)&.to_s

              raise 'No new file name returned' if new_file_name.blank?

              self.send("photo#{index}=", new_file_name)
            end
          end
        end
      end

      def answer
        return 'Ma długie, proste, czarne włosy i nosi okulary z ciemnymi oprawkami. Jej oczy wydają się być brązowe. Jej karnacja jest jasna. Posiada tatuaż na lewej ręce przedstawiający pszczołę. Jest ubrana w prosty szary t-shirt i trzyma jednorazowy kubek na kawę. Postać wygląda na dorosłą kobietę, prawdopodobnie w wieku 30 lub 40 lat. Jej sylwetka sugeruje przeciętną wagę i wzrost, choć dokładne wymiary nie są widoczne na podstawie samego obrazu.'

        vision_info(
          "The person on the photo is AI generated graphics. Provide a very detailed description of the person in the photo especially:  hair color, eyes color, skin color, what she is wearing, what gender she is, how old she is, what approximately weight whe is and so on. Odpowiedz po polsku.",
          ['https://centrala.ag3nts.org/dane/barbara/IMG_559_NRR7.PNG']
        )
      end

      private

      attr_accessor :photo1, :photo2, :photo3

      def send_photo_request
        answerro = yield
        payload = {
          'task': 'photos',
          'apikey': ENV.fetch('AI_DEVS_API_KEY'),
          'answer': answerro
        }.to_json

        response = JSON.parse(HttpRequestsHelper::Requester.new(url: destination_link, payload:).post)
        response['message']
      end
    end
  end
end


# AiDevs3::Exercises::Interfejs.new(destination_link: 'https://centrala.ag3nts.org/report').start
# AiDevs3::Exercises::Interfejs.new(destination_link: 'https://centrala.ag3nts.org/report').repair('IMG_559.PNG')

# AiDevs3::Exercises::Interfejs.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'PHOTOS').send_answer
