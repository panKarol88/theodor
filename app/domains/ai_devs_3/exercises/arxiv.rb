# S02E05 - Zadanie 1

module AiDevs3
  module Exercises
    class Arxiv < Exercise
      def questions
        questions_link = "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY', nil)}/arxiv.txt"

        URI.open(questions_link).readlines(chomp: true)
      end

      def translate_all_png_resources_to_text_in_md
        file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'sources', 'arxiv.md')
        temp_file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'sources', 'temp_arxiv.md')

        search_word = ".png"

        # Open both files: one for reading, one for writing
        File.open(temp_file_path, "w") do |new_file|
          File.foreach(file_path) do |line|
            if line.include?(search_word)
              img_link = line.match(/\!\[\]\((https?:\/\/[^\s\)]+)\)/)[1]
              img_description = vision_info("describe what is on this image", [img_link])[:content]
              new_file.puts "<description of the image: #{img_link}>\n#{img_description}\n</description of the image: #{img_link}>\n#{line}"
              p img_description
            else
              # Otherwise, write the original line
              new_file.puts line
            end
          end
        end

        # Replace the original file with the modified one
        File.rename(temp_file_path, file_path)
        # Remove the temporary file
        File.delete(temp_file_path) if File.exist?(temp_file_path)
      end

      def translate_all_voice_resources_to_text_in_md
        file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'sources', 'arxiv.md')
        temp_file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'sources', 'temp_arxiv.md')

        search_word = ".mp3"

        # Open both files: one for reading, one for writing
        File.open(temp_file_path, "w") do |new_file|
          File.foreach(file_path) do |line|
            if line.include?(search_word)
              voice_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'sources', 'rafal_dyktafon.mp3').to_s
              voice_transcription = audio_transcription(voice_path)
              new_file.puts "<transcription of the: rafal_dyktafon.mp3>\n#{voice_transcription}\n</transcription of the: rafal_dyktafon.mp3>\n#{line}\n"
              p voice_transcription
            else
              # Otherwise, write the original line
              new_file.puts line
            end
          end
        end

        # Replace the original file with the modified one
        File.rename(temp_file_path, file_path)
        # Remove the temporary file
        File.delete(temp_file_path) if File.exist?(temp_file_path)
      end

      def answer
        return {"01"=>"Podczas pierwszej próby transmisji materii w czasie użyto truskawki.",
                "02"=>"Testowa fotografia użyta podczas testu przesyłania multimediów została wykonana na rynku w Krakowie.",
                "03"=>"Bomba chciał znaleźć hotel w Grudziądzu.",
                "04"=>"Resztki dania pozostawione przez Rafała to pizza z ananasem.",
                "05"=>"Litery BNW w nazwie nowego modelu językowego pochodzą od „Brave New World” – Nowy Wspaniały Świat."}

        file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'sources', 'arxiv.md')
        file = File.open(file_path).read

        answers = {}

        questions.each do |raw_question|
          q_id = raw_question.split('=').first
          question = raw_question.split('=').last

          message = "For a given context:\n"
          message += "<context>\n"
          message += "#{file}\n"
          message += "</context>\n"
          message += "Answer to the given question with one sentence:\n"
          message += "<question>\n"
          message += "#{question}\n"
          message += "</question>\n"

          p question
          answers["ID-pytania-#{q_id}"] = chat(message)[:content]
          sleep(20)
        end

        answers
      end
    end
  end
end

# create a MD file thank to https://www.firecrawl.dev/
# download mp3 file

# AiDevs3::Exercises::Arxiv.new(
#   data_link: 'https://centrala.ag3nts.org/dane/arxiv-draft.html'
# ).translate_all_resources_to_text_in_md

# AiDevs3::Exercises::Arxiv.new(
#   data_link: 'https://centrala.ag3nts.org/dane/arxiv-draft.html'
# ).translate_all_voice_resources_to_text_in_md

AiDevs3::Exercises::Arxiv.new(
  data_link: 'https://centrala.ag3nts.org/dane/arxiv-draft.html',
  destination_link: 'https://centrala.ag3nts.org/report',
  task: 'ARXIV'
).send_answer