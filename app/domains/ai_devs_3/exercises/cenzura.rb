# S01E05 - Zadanie 1

module AiDevs3
  module Exercises
    class Cenzura < Exercise
      def file
        data = URI.open(data_link).readlines(chomp: true)
        p data
        data
      end

      def prompt
        message = "w podanym tekście zastąp wszystkie słowa, które mogą być imieniem lub nazwiskiem lub wiekiem lub miastem lub ulicą z numerem domu, słowem 'CENZURA'\n"
        message += '<przykład1>\n'
        message += '- input: "Osoba podejrzana to Andrzej Mazur. Adres: Gdańsk, ul. Długa 8. Wiek: 29 lat."\n'
        message += '- output: "Osoba podejrzana to CENZURA. Adres: CENZURA, ul. CENZURA. Wiek: CENZURA lat."\n'
        message += '</przykład1>\n'
        message += '<przykład2>\n'
        message += '- input: "Informacje o podejrzanym: Adam Nowak. Mieszka w Katowicach przy ulicy Tuwima 10. Wiek: 32 lata."\n'
        message += '- output: "Informacje o podejrzanym: CENZURA. Mieszka w CENZURA przy ulicy CENZURA. Wiek: CENZURA lata."\n'
        message += '</przykład2>\n'
        message += '<tekst>\n'
        message += file[0]
        message += '</tekst>\n'
        message
      end

      def answer
        result = chat(prompt)
        p result
        result[:content]
      end
    end
  end
end

# imię i nazwisko, wiek, miasto i ulicę z numerem domu

# AiDevs3::Exercises::Cenzura.new(
#   data_link: "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY')}/cenzura.txt",
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'CENZURA').send_answer
