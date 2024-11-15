# S02E04 - Zadanie 1

module AiDevs3
  module Exercises
    class Kategorie < Exercise
      def initialize(data_link: nil, destination_link: nil, task: nil)
        super(data_link: data_link, destination_link: destination_link, task: task)

        @people = []
        @hardware = []
      end

      attr_reader :people, :hardware

      def file_dirs
        @file_dirs ||= begin
                         dir = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki')
                         file_names = Dir.entries(dir).select { |f| !File.directory? f }
                         file_names.select { |f| f.match(/\.png|\.txt|\.mp3/) }
                       end
      end

      def process_txt_files
        file_dirs.select{ |f| f.match(/\.txt/) }.each do |file_name|
          next if file_name == '2024-11-12_report-99.png.txt'

          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', file_name)
          text = File.read(file_path)

          message = 'Spokojnie odczytaj podany tekst. Krótko, opisz go własnymi słowami.'
          message += 'Następnie zastanów się czy podany tekst można zaklasyfikować jako:'
          message += '\"people"\ czyli opis osoby która została pojmana'
          message += 'oraz \"hardware\" czyli opis fizycznego sprzętu który został naprawiony (nie ma to nic wspólnego z jakimkolwiek oprogramowaniem).'
          message += 'A następnie wyświetl podsumowanie w takiej formie: <result>{ \"people\": true/false, \"hardware\": true/false }</result>'
          message += "<podany tekst>#{text}</podany tekst>"
          message += 'Przykłady:'
          message += '<przykład1>'
          message += 'input: Znalazłem więźnia w magazynie. Wiozę go na posterunek.'
          message += 'output: <result>{ \"people\": true, \"hardware\": false }</result>'
          message += '</przykład1>'
          message += '<przykład2>'
          message += 'input: Ten pracownik ma coś nie po kolei w głowie. Idę naprawić śrubokręt.'
          message += 'output: <result>{ \"people\": true, \"hardware\": true }</result>'
          message += '</przykład2>'
          message += '<przykład3>'
          message += 'input: Lubięe placki.'
          message += 'output: <result>{ \"people\": false, \"hardware\": false }</result>'
          message += '</przykład3>'
          message += '<przykład4>'
          message += 'input: Znam jednego gościa co robi pizze.'
          message += 'output: <result>{ \"people\": false, \"hardware\": false }</result>'
          message += '</przykład4>'
          message += '<przykład5>'
          message += 'input: Poprawiono aktualizację modułu sterującego.'
          message += 'output: <result>{ \"people\": false, \"hardware\": false }</result>'
          message += '</przykład5>'
          message += '<przykład6>'
          message += 'input: Istnieje coś takiego jak miotacz ognia.'
          message += 'output: <result>{ \"people\": false, \"hardware\": false }</result>'
          message += '</przykład6>'
          message += '<przykład7>'
          message += 'input: Do miotacza ognia dołączono celownik co poprawiło jego celowność.'
          message += 'output: <result>{ \"people\": false, \"hardware\": true }</result>'
          message += '</przykład7>'

          p text
          raw_response = chat(message)[:content].split('<result>')[1].split('</result>')[0]
          json_response = JSON.parse(raw_response).with_indifferent_access
          people << file_name.split('.')[0..1].join('.') if json_response[:people]
          hardware << file_name.split('.')[0..1].join('.') if json_response[:hardware]
        end
      end

      def convert_images_to_text
        file_dirs.select{ |f| f.match(/\.png/) }.each do |file_name|
          next if "#{file_name}.txt".in?(file_dirs) || file_name.split('.').count > 2
          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', file_name)
          file_data = File.open(file_path, "rb") { |file| file.read }
          base64_image = "data:image/png;base64,#{Base64.strict_encode64(file_data)}"
          prompt = 'Detect text in the image and print it. Nothing else. No summary, no greeting, no nothing. Only text from the image'
          text = vision_info(prompt, [base64_image])[:content]
          File.open(Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', "#{file_name}.txt"), 'w') { |file| file.write(text) }
        end
      end

      def convert_mp3_to_text
        file_dirs.select{ |f| f.match(/\.mp3/) }.each do |file_name|
          next if "#{file_name}.txt".in?(file_dirs) || file_name.split('.').count > 2
          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', file_name)
          text = audio_transcription(file_path.to_s)
          File.open(Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', "#{file_name}.txt"), 'w') { |file| file.write(text) }
        end
      end

      def answer
        # convert_images_to_text
        # convert_mp3_to_text
        # process_txt_files
        #
        # { people:, hardware: }

        {people: ["2024-11-12_report-00-sektor_C4.txt", "2024-11-12_report-10-sektor-C1.mp3", "2024-11-12_report-07-sektor_C4.txt"], hardware: ["2024-11-12_report-13.png", "2024-11-12_report-15.png", "2024-11-12_report-17.png"]}
      end
    end
  end
end

# AiDevs3::Exercises::Kategorie.new.answer

# AiDevs3::Exercises::Kategorie.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'KATEGORIE').send_answer
