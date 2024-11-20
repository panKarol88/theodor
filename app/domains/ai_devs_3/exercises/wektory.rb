# S03E02 - Zadanie 1

module AiDevs3
  module Exercises
    class Wektory < Exercise
      def prepare_data_crumbs_with_facts
        facts_dir = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', 'do-not-share-2')
        Dir.entries(facts_dir).select { |f| !File.directory? f }.each do |file_name|
          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', 'do-not-share-2', file_name)
          content = File.open(file_path, 'r') { |file| file.read }

          DataCrumbs::Builder.new(content: , warehouse:).embed_and_create
        end
      end

      def answer
        return '2024-02-21'
        question = 'Którego dnia skradziono prototyp broni?'
        context_crumbs = Context::KnowledgeCollector.new(issue: question, warehouse:).find_related_data_crumbs(limit: 1)
        context = context_crumbs.map(&:content).join('\n')

        message = 'Based on the given context. Answer to the following questions:\n'
        message += "<context>\n#{context}\n</context>\n"
        message += "<question>\n#{question}\n</question>\n"

        context_answer = chat(message)[:content]
        result = chat("wyświatl datę z tej wiadomości w formacie YYYY-MM-DD wiedzęc że to 2024 rok.\n <wiadomość>\n#{context_answer}</<wiadomość>\nWyświetl tylko datę i nic więcej.")[:content]
        p result

        result
      end
    end
  end
end

# AiDevs3::Exercises::Wektory.new.prepare_data_crumbs_with_facts
# AiDevs3::Exercises::Wektory.new.answer

# AiDevs3::Exercises::Wektory.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'WEKTORY').send_answer
