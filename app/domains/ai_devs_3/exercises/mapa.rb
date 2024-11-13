# S02E01 - Zadanie 1
# FLAGA: GRUDZIĄDZ

module AiDevs3
  module Exercises
    class Mapa < Exercise
      def photos
        images = []

        %w[one two three four].each do |file_name|
          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'zdjecia_mapy', "#{file_name}.png")
          file_data = File.open(file_path, "rb") { |file| file.read }
          base64_image = Base64.strict_encode64(file_data)
          images << "data:image/png;base64,#{base64_image}"
        end

        images
      end

      def answer
        vision_info("Gdzieś tu jest ukryta tajna wiadomość. Jak ją znaleźć? Jak ona brzmi?", photos)
      end
    end
  end
end

# AiDevs3::Exercises::Mapa.new.answer
