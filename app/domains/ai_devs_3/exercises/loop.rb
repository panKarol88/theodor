# S03E04 - Zadanie 1

module AiDevs3
  module Exercises
    class Loop < Exercise
      attr_reader :who_is_where, :names, :cities

      def initialize(data_link: nil, destination_link: nil, task: nil)
        super(data_link:, destination_link:, task:)

        @who_is_where = {}
        @names = init_data[:names]
        @cities = init_data[:cities]
      end

      def answer
        return 'ELBLAG'

        {
          "ALEKSANDER"=>["KRAKOW", "LUBLIN", "WARSZAWA"],
          "ANDRZEJ"=>["WARSZAWA", "GRUDZIADZ"],
          "RAFAL"=>["GRUDZIADZ", "WARSZAWA", "LUBLIN"],
          "BARBARA"=>["KRAKOW", "ELBLAG"],
          "ADAM"=>["KRAKOW", "CIECHOCINEK"],
          "RAFAŁ"=>["WARSZAWA"],
          "AZAZEL"=>["GRUDZIADZ", "WARSZAWA", "KRAKOW", "LUBLIN", "ELBLAG", "FROMBORK"],
          "GABRIEL"=>["CIECHOCINEK", "FROMBORK"],
          "ARTUR"=>["FROMBORK", "KONIN"],
          "GLITCH"=>["KONIN", "https://centrala.ag3nts.org/dane/na_smartfona.png"]
        }
      end

      def crazy_loop_who_is_where
        dirty = true

        while dirty
          p who_is_where
          dirty = false

          names.each do |name|
            people(name).each do |city|
              if who_is_where.key?(name)
                who_is_where[name] << city if who_is_where[name].exclude?(city)
              else
                who_is_where[name] = [city]
              end
              unless cities.include?(city)
                cities << city
                dirty = true
              end
            end
          end

          cities.each do |city|
            places(city).each do |name|
              if who_is_where.key?(name)
                who_is_where[name] << city if who_is_where[name].exclude?(city)
              else
                who_is_where[name] = [city]
              end
              unless names.include?(name)
                names << name
                dirty = true
              end
            end
          end
        end

        who_is_where
      end

      def info
        'Podczas pobytu w Krakowie w 2019 roku, Barbara Zawadzka poznała swojego ówczesnego narzeczonego, a obecnie męża, Aleksandra Ragowskiego. Tam też poznali osobę prawdopodobnie powiązaną z ruchem oporu, której dane nie są nam znane. Istnieje podejrzenie, że już wtedy pracowali oni nad planami ograniczenia rozwoju sztucznej inteligencji, tłumacząc to względami bezpieczeństwa. Tajemniczy osobnik zajmował się także organizacją spotkań mających na celu podnoszenie wiedzy na temat wykorzystania sztucznej inteligencji przez programistów. Na spotkania te uczęszczała także Barbara. W okolicach 2021 roku Rogowski udał się do Warszawy celem spotkania z profesorem Andrzejem Majem. Prawdopodobnie nie zabrał ze sobą żony, a cel ich spotkania nie jest do końca jasny. Podczas pobytu w Warszawie, w instytucie profesora doszło do incydentu, w wyniku którego, jeden z laborantów - Rafał Bomba - zaginął. Niepotwierdzone źródła informacji podają jednak, że Rafał spędził około 2 lata, wynajmując pokój w pewnym hotelu. Dlaczego zniknął?  Przed kim się ukrywał? Z kim kontaktował się przez ten czas i dlaczego ujawnił się po tym czasie? Na te pytania nie znamy odpowiedzi, ale agenci starają się uzupełnić brakujące informacje. Istnieje podejrzenie, że Rafał mógł być powiązany z ruchem oporu. Prawdopodobnie przekazał on notatki profesora Maja w ręce Ragowskiego, a ten po powrocie do Krakowa mógł przekazać je swojej żonie. Z tego powodu uwaga naszej jednostki skupia się na odnalezieniu Barbary. Aktualne miejsce pobytu Barbary Zawadzkiej nie jest znane. Przypuszczamy jednak, że nie opuściła ona kraju.'
      end

      def init_data
        return {
          names: %w[BARBARA ALEKSANDER ANDRZEJ RAFAL],
          cities: %w[KRAKOW WARSZAWA]
        }

        message = "<text>\n#{info}\n</text>\n"
        message += 'Think of all cities and people that are mentioned in the text above.\n'
        message += 'List them below, separating them with commas. Following the rules and examples below:\n'
        message += '<rules>\n'
        message += '- names and cities should be in uppercase\n'
        message += '- names and cities should be polish words in mianownik\n'
        message += '- names and cities should not contain any special characters; change "ó" into "o" or "ł" into "l" and so on \n'
        message += '- names should be comma separated between <names> and </names> tags\n'
        message += '- names should be only first names\n'
        message += '- cities should be comma separated between <cities> and </cities> tags\n'
        message += '</rules>\n'
        message += '<example1>\n'
        message += '- input: Tomek był kiedyś w Krakowie.\n'
        message += '- output: <names>TOMASZ</names><cities>KRAKOW</cities>\n'
        message += '</example1>\n'
        message += '<example2>\n'
        message += '- input: Kasia Kowalska lubiła jeździć do Radomia odwiedzić babcię. Jej babcia miała na imię Basia.\n'
        message += '- output: <names>KATARZYNA, BARBARA</names><cities>RADOM</cities>\n'
        message += '</example2>\n'

        chat(message)[:content]
      end

      def people(name)
        payload = {
          apikey: ENV.fetch('AI_DEVS_API_KEY'),
          query: name
        }.to_json

        response = JSON.parse(HttpRequestsHelper::Requester.new(url: 'https://centrala.ag3nts.org/people', payload:).post)
        p response

        return response['message'].split if response['code'] == 0 && response['message'] != '[**RESTRICTED DATA**]'

        []
      end

      def places(place)
        payload = {
          apikey: ENV.fetch('AI_DEVS_API_KEY'),
          query: place
        }.to_json

        response = JSON.parse(HttpRequestsHelper::Requester.new(url: 'https://centrala.ag3nts.org/places', payload:).post)
        p response

        return response['message'].split if response['code'] == 0 && response['message'] != '[**RESTRICTED DATA**]'

        []
      end
    end
  end
end

# AiDevs3::Exercises::Loop.new.people('BARBARA')
# AiDevs3::Exercises::Loop.new.places('RADOM')
# AiDevs3::Exercises::Loop.new.init_data
# AiDevs3::Exercises::Loop.new.crazy_loop_who_is_where

# AiDevs3::Exercises::Loop.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'LOOP').send_answer
