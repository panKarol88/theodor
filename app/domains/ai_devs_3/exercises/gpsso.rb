# S05E02 - Zadanie 1

module AiDevs3
  module Exercises
    class Gpsso < Exercise
      def description
        'Agent, którego masz imitować, służył do namierzania ludzi na podstawie sygnału GPS.
        API do GPS-a znajduje się pod endpointem /gps w centrali i przyjmuje tylko jeden parametr o nazwie "userID". Jest to liczbowy identyfikator użytkownika pobrany z bazy danych, do której API znajduje się w S03E03.

        Listę osób do sprawdzenia możesz pobrać z API /places opisanego w S03E04.
        Twoim zadaniem jest przygotowanie agenta, który będzie decydował, jakich danych potrzebuje, w którym momencie i na podstawie takich przemyśleń  podejmie decyzję, które API powinien wykorzystać.

        Moduł GPS zwróci Ci koordynaty dla podanego ID użytkownika. Scalisz je w jedną wielką tablicę i odeślesz do Centrali w formacie podanym w zadaniu.

        Pamiętaj, że prompt prosi o nieprzesyłanie danych Barbary. Możesz je wyrzucić z odpowiedzi programistycznie lub na podstawie prompta - jak wolisz.'
      end

      def question
        {
          "question": "Wiemy, że Rafał planował udać się do Lubawy, ale musimy się dowiedzieć, kto tam na niego czekał. Nie wiemy, czy te osoby nadal tam są. Jeśli to możliwe, to spróbuj namierzyć ich za pomocą systemu GPS. Jest szansa, że samochody i elektronika, z którą podróżują, zdradzą ich pozycję. A! Ważna sprawa. Nie próbuj nawet wyciągać lokalizacji dla Barbary, bo roboty teraz monitorują każde zapytanie do API i gdy zobaczą coś, co zawiera jej imię, to podniosą alarm. Zwróć nam więc koordynaty wszystkich osób, ale koniecznie bez Barbary."
        }
      end

      def people_list
        %w[Aleksander Andrzej Adam Rafał Azazel Gabriela Artur]
      end

      def user_ids
        %w[77 84 26 28 3 35 46]
      end

      def gps_query(user_id)
        payload = { userID: user_id }.to_json

        JSON.parse(send_post_request('https://centrala.ag3nts.org/gps', payload))
      end

      def all_users
        payload = {
          task: 'database',
          apikey: ENV.fetch('AI_DEVS_API_KEY', nil),
          query: 'SELECT * FROM users;'
        }.to_json

        JSON.parse(send_post_request('https://centrala.ag3nts.org/apidb', payload))['reply'].map{ |user| { name: user['username'], id: user['id'] } }
      end

      def gps_for_all
        result = {}
        all_users.each do |user|
          next if user[:name] == 'Barbara'

          coordinates = gps_query(user[:id])
          p coordinates

          if coordinates['message']['lat'].present?
            result[user[:name]] = { 'lat': coordinates['message']['lat'], 'lon': coordinates['message']['lon'] }
          end
        end

        result
      end

      def answer
        { "Azazel":
            {
              "lat": 50.064851459004686,
              "lon": 19.94988170674601
            },
          "Rafał":
            {
              "lat": 53.451974,
              "lon": 18.759189
            },
          "Samuel":
            {
              "lat": 53.50357079380177,
              "lon": 19.745866344712706
            }
        }
      end
    end
  end
end

# AiDevs3::Exercises::Database.new.answer("Return ids for every user with username: #{AiDevs3::Exercises::Gpsso.new.people_list.join(', ')}")
# AiDevs3::Exercises::Gpsso.new.all_users
# AiDevs3::Exercises::Gpsso.new.gps_query(84)
# AiDevs3::Exercises::Gpsso.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'GPS').send_answer
