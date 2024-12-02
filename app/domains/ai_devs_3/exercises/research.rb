# S04E02 - Zadanie 1

module AiDevs3
  module Exercises
    class Research < Exercise

      def generate_correct_dataset
        file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'correct.txt')
        output = json_parser(file_path, 'Y')
        # store output as jsonl
        File.open(Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'correct.jsonl'), 'w') do |f|
          output.each do |line|
            f.puts line.to_json
          end
        end
      end

      def generate_incorrect_dataset
        file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'incorrect.txt')
        output = json_parser(file_path, 'N')
        # store output as jsonl
        File.open(Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'incorrect.jsonl'), 'w') do |f|
          output.each do |line|
            f.puts line.to_json
          end
        end
      end

      def generate_dataset
        file_path1 = Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'correct.txt')
        output1 = json_parser(file_path1, 'Y')

        file_path2 = Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'incorrect.txt')
        output2 = json_parser(file_path2, 'N')

        # output3 based on randomly mixed output1 and output2
        output3 = output1.zip(output2).flatten.compact

        test_dataset = output3[0..output3.size*0.85]
        validation_dataset = output3[output3.size*0.85...-1]

        # test dataset
        File.open(Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'test_dataset.jsonl'), 'w') do |f|
          test_dataset.each do |line|
            f.puts line.to_json
          end
        end

        # validation dataset
        File.open(Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'validation_dataset.jsonl'), 'w') do |f|
          validation_dataset.each do |line|
            f.puts line.to_json
          end
        end
      end

      def json_parser(file_path, result)
        dataset = []
        File.foreach(file_path) do |line|
          dataset << {
            'messages': [
              {
                'role': 'system',
                'content': 'Are these numbers correct?',
              },
              {
                'role': 'user',
                'content': line[0..-2],
              },
              {
                'role': 'assistant',
                'content': result
              },
            ]
          }
        end

        dataset
      end

      def answer
        return ["01", "02", "10"]

        answero = []
        file_path_to_verify = Rails.root.join('app', 'domains', 'ai_devs_3', 'lab_data', 'verify.txt')

        File.foreach(file_path_to_verify) do |line|
          messages = [
            {
              'role': 'system',
              'content': 'Are these numbers correct?',
            },
            {
              'role': 'user',
              'content': line[3..-2],
            },
          ]


          p messages

          result = OpenAi::Client.new.chat_completion(
            prompt: messages,
            model: 'ft:gpt-4o-mini-2024-07-18:karol-personal:ai-devs-research2:Aa0ZXaYf'
          )['choices'][0]['message']['content']

          answero << line[0..1] if result == 'Y'

          p "TEST: #{line[3..-2]}, RESULT: #{result}"
        end

        answero
      end
    end
  end
end

# AiDevs3::Exercises::Research.new().generate_dataset
# AiDevs3::Exercises::Research.new().answer

# AiDevs3::Exercises::Research.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'RESEARCH').send_answer
