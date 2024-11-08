# S01E03 - Zadanie 1

module AiDevs3
  module Exercises
    class Json < Exercise
      def source_file
        URI.open(data_link).readlines(chomp: true)
      end

      def json_source
        @json_source ||= JSON.parse(source_file.join)
      end

      def ask_bot(question)
        p question

        chat_message = 'Answer the following question:\n'
        chat_message += "## QUESTION ## #{question} ######\n"
        chat_message += 'Always return only one word and nothing else.\n'
        answer_payload = chat(chat_message)
        p answer_payload

        answer_payload[:content]
      end

      def answer
        json_source['apikey'] = ENV.fetch('AI_DEVS_API_KEY', nil)

        json_source["test-data"].each_with_index do |item, index|
          item['answer'] = eval(item["question"])
          if item['test'].present?
            item['test']['a'] = ask_bot(item['test']['q'])
          end

          json_source["test-data"][index] = item
        end

        json_source
      end
    end
  end
end

# AiDevs3::Exercises::Json.new(data_link: "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY', nil)}/json.txt").answer

# AiDevs3::Exercises::Json.new(
#   data_link: "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY', nil)}/json.txt",
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'JSON'
# ).send_answer
#
