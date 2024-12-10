# S05E01 - Zadanie 1

module AiDevs3
  module Exercises
    class Phone < Exercise
      def conversation
        {
          "rozmowa1": [
            "- Hej! Jak tam agentko? Jak się czujesz po rozmowie?",
            "- No cześć. Trochę nieswojo, ale jakoś to będzie. On był w naprawdę kiepskim stanie. Trudno się z nim rozmawiało",
            "- Ale zrozumiał coś z tego, co mu powiedziałaś?",
            "- ten stan nawet ułatwiał, a nie utrudniał zadanie. Chłonął wiedzę jak gąbka. Myślę, że wszystko zrozumiał.",
            "- To dobrze, że zrozumiał. A co z tymi dokumentami, o których rozmawialiśmy?",
            "- dokumenty? Mówił, że wszystko ma w komputerze, ale gość nie miał przy sobie żadnego sprzętu. W tej norze nawet prądu nie było.",
            "- To co teraz zrobimy? Trzeba ich szukać u niego w mieszkaniu, bo tam chyba zostawił sprzęt?",
            "- pewnie tak, ale gdzie jest to jego mieszkanie? Obecnie to chyba ta jaskinia nazywana jest przez niego \"domem\" hahaha",
            "- a zdalny dostęp do jego kompa wchodzi w grę jeśli nie możemy iść do mieszkania?",
            "- myślę, że tak. Zdalnie sobie poradzimy. Goście z centrali kombinują coś z przeszukiwaniem całej puli adresów IP. Jak tylko coś znajdą, to dam Ci znać. Sama jestem ciekawa na ile on zabezpieczył swój sprzęt i co tam w miał w środku.",
            "- no to czekam na informację jak już znajdą to IP, a on jest już z Tobą?",
            "- nie ma go tutaj. Wiesz co... trochę się sprawy pokomplikowały. Niezupełnie to wszystko poszło zgodnie z planem.",
            "- poszło niezgodnie z planem? uciekł Ci gość?",
            "- nie uciekł. Gość nie żyje... Goście z centrali wysłali tam drona. Dowiedziałam się o wszystkim z raportu",
            "- coooo? jak to możliwe? Rozmawiamy, a Ty jakby nigdy nic mówisz, że \"nie żyje\"? Kiedy miałaś zamiar mi powiedzieć? no i skąd oni wiedzieli gdzie szukać? To była przecież jaskinia na odludziu!",
            "- czy to jest teraz ważne skąd?! Andrzej miał nadajnik GPS w samochodzie, to go namierzyli nawet na tym odludziu. No zawaliłam z tym. Wiem, ale ważniejsze jest teraz to, że gość nie żyje i nie mamy dostępu do jego komputera. To jest najważniejsze. Kurwa, wiesz [*niesłyszalne*], żal mi gościa... ",
            "- żal Ci... żal... ale on nie wykonał zadania. Fuck!!!!",
            "- no nie wykonał! i już raczej nie wykona w tym stanie... Andrzeja też już nie ma i nie wiadomo gdzie jest. Zwiał",
            "- no to wyciągnij z centrali informację w którym kierunku pojechał Andrzej!",
            "- problem w tym, że zostawił swój samochód, więc nie za bardzo \"pojechał\". Może on mu powiedział o nadajniku?",
            "- a to on wiedział, że Andrzej ma nadajnik w samochodzie?",
            "- a kto to wie... przecież [*niesłyszalne*] nigdy nie wiadomo co on tam wiedział i czy był świadomy nadajnika. Możemy się tylko domyślać.",
            "- Dobra. Uznajmy, że wiedział o nadajniku. A zostały jakieś Twoje ślady w jaskini jak tam byłaś? mogą się zorientować, żę go odwiedzałaś?",
            "- byłam tam normalnie, jawnie. Umówiłam się oficjalnie, że będę go uczyła JavaScriptu. Miał mu się przydać do szkolenia tego, co teraz przerabia. Na papierze treść lekcji czyta, to mu chciałam trochę potłumaczyć to wszystko. Nie chciałam przecież mówić wprost po co przyjeżdżam.",
            "- no ja nie mogę... na czym go miałaś uczyć tego JavaScriptu? Gość nie ma kompa czaisz?! Na glinianych tabliczkach mieliście pisać te programy dłutem? Teraz wiedzą, że tam byłaś! Dobra, nara! Mam Zygfryda na drugiej linii [*dźwięk odkładanej słuchawki*]"
          ],
          "rozmowa2": [
            "- Witaj Samuelu. Rozmawiałeś z nią?",
            "- tak. Dosłownie przed chwilą rozmawiałem, gdy zadzwoniłeś, ale nic od niego nie wydobyła",
            "- dlaczego? nie wykonała zadania? co z nią?",
            "- rozmawiała z nim, ale nie zdołała zdobyć brakujących informacji. Mówił, że wszystko ma w komputerze, ale nie miał przy sobie żadnego sprzętu. Do tego durna baba jako wymówkę wzięła \"naukę JavaScriptu\". Czaisz? dżejesa go będzie uczyć! W centrali mają teraz pewnie niezły ubaw. Poza tym, to... Zygfryd, Ty słyszałeś co się stało?",
            "- Tak Samuelu. Słyszałem. Wiem o wszystkim. Przede mną się to nie ukryje.",
            "- no ja nie mogę... ale to spokojnie przyjmujesz. Po prostu \"słyszałem\"? Gościa już nie ma! Nie żyje! Oni chyba [*niezrozumiałe dźwięki*] i gość nie żyje! [*niezrozumiałe dźwięki*] więc musimy [*trzaski*] więc [*trzaski*] bo dron [*trzaski*]",
            "- hej! jesteś tam? Coś słabo Cię słychać. Słychać tylko trzaski i przerywa mocno. Halooooo?"
          ],
          "rozmowa3": [
            "- Samuelu! helooo?! Słyszysz mnie teraz? Zadzwoniłem ponownie, bo chyba znowu z zasięgiem jest u Ciebie jakiś problem...",
            "- tak Zygfryd, słyszę Cię teraz dobrze. Przepraszam, gdy poprzednio dzwoniłeś, byłem w fabryce. Wiesz, w sektorze D, gdzie się produkuje broń i tutaj mają jakąś izolację na ścianach dodatkową. Telefon gubi zasięg. Masz jakieś nowe zadanie dla mnie?",
            "- tak. Mam dla Ciebie nowe zadanie. Skontaktuj się z Tomaszem. On pracuje w Centrali. Może pomóc Ci włamać się do komputera tego gościa. Masz już endpoint API?",
            "- tak, mam ten endpoint. https://rafal.ag3nts.org/510bc - Dzięki. Zadzwonię do Tomasza dopytać o resztę. Coś jeszcze?",
            "- Nie, to wszysto. No to weź teraz ten endpoint i użyj do połączenia. Tomasz powie Ci jakie jest hasło do pierwszej warstwy zabezpieczeń. OK. Nie marnuj czasu. Dzwoń!",
            "- OK. Dzwonię do Tomasza. [*dźwięk odkładanej słuchawki*]"
          ],
          "rozmowa4": [
            "- Cześć Tomasz. Tu Samuel. Dostałem ten numer od szefa. Potrzebuję hasła do pierwszej warstwy zabezpieczeń kompa sam wiesz kogo. Możesz mi pomóc?",
            "- Aaaa hej! hej!. Tak, mogę Ci pomóc. Hasło do pierwszej warstwy to \"NONOMNISMORIAR\".",
            "- mmmm... takie filozoficzne to hasło i w sumie pasuje teraz do kontekstu haha! Spoko. Dzięki. A kolejne warstwy?",
            "- Nie wiem. Siedzę nad tymi warstwami już od kilku dni i powiem Ci, że on musiał używać technologii z przyszłości, bo nasze LLM-y są zbyt wolne, aby przejść kolejne warstwy weryfikacji. Bez skoku w czasie i pomocy Zygfryda chyba się nie uda",
            "- wiesz dobrze, że skakać w czasie może teraz tylko Azazel, a z nim to nie ma rozmowy. Ale dobra... Zygfryd nakręci numer piąty na złamanie tego.",
            "- to piątka nadal się niczego nie domyśla?",
            "- piątka to posłuszna owieczka. Wykonuje polecenia, ale nie wie co robi. Dobra, dzięki za hasło. Przekażę je numerowi piątemu [*dźwięk odkładanej słuchawki*]"
          ],
          "rozmowa5": [
            "- Halo? Jesteś tam? tu Witek. Potrzebuję Twojej pomocy.",
            "- no siema Witek! Jestem, jestem. Rozmawiałam z Samuelem. Chyba się na mnie trochę wkurzył. Jak Ci mogę pomóc?",
            "- Ty się znasz na programowaniu, security i tym całym IT, nie? Potrzebuję pomocy w złamaniu zabezpieczeń komputera. Mam endpoint API. Możesz mi w tym pomóc?",
            "- no to daj adres do API. Pokombinuję coś sama, albo zapytam mądrzejszych od siebie",
            "- trzymaj, to jest ten endpoint do API: https://rafal.ag3nts.org/b46c3 ale nie mam hasła do niego",
            "- a skąd Ty masz ten endpoint i do tego bez hasła? Jak go zdobyłeś?",
            "- aaa wiesz. Ten Twój \"nauczyciel\" mi go dostarczył, ale hasła jeszcze nie zdobył, ale pracuje on nad tym",
            "- haha... przestań tak o nim mówić. Wiesz przecież, jak on się wkurza, gdy się go nazwie nauczycielem. Dobra, daj mi chwilę. Będę próbowała coś z tym pokombinować.",
            "- jasne mała! powodzenia z tym kombinowaniem. Bądź jak Helmut Rahn w 1954 roku i pokaż im na co Cię stać! [*dźwięk odkładanej słuchawki*]"
          ]
        }
      end

      def questions
        {
          "01": "Jeden z rozmówców skłamał podczas rozmowy. Kto to był?",
          "02": "Jaki jest prawdziwy endpoint do API podany przez osobę, która NIE skłamała?",
          "03": "Jakim przezwiskiem określany jest chłopak Barbary?",
          "04": "Jakie dwie osoby rozmawiają ze sobą w pierwszej rozmowie? Podaj ich imiona",
          "05": "Co odpowiada poprawny endpoint API po wysłaniu do niego hasła w polu \"password\" jako JSON?",
          "06": "Jak ma na imię osoba, która dostarczyła dostęp do API, ale nie znała do niego hasła, jednak nadal pracuje nad jego zdobyciem?"
        }
      end

      def prepare_data_crumbs_with_facts
        facts_dir = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', 'facts')
        Dir.entries(facts_dir).select { |f| !File.directory? f }.each do |file_name|
          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', 'facts', file_name)
          content = File.open(file_path, 'r') { |file| file.read }

          next if content == 'entry deleted\n'

          DataCrumbs::Builder.new(content: , warehouse: Warehouse.find_by(name: 'ai_devs')).embed_and_create
        end
      end

      def warehouse
        @warehouse ||= Warehouse.find_by(name: 'ai_devs')
      end

      def api_response
        payload = { password: 'NONOMNISMORIAR' }.to_json
        JSON.parse(HttpRequestsHelper::Requester.new(url: 'https://rafal.ag3nts.org/b46c3', payload:).post)['message']
      end

      def answer
        {
          '01': 'Samuel',
          '02': 'https://rafal.ag3nts.org/b46c3',
          '03': 'nauczyciel',
          '04': 'Samuel, Barbara',
          '05': api_response,
          '06': 'Aleksander',
        }
      end

      def answerro
        question = 'Jak ma na imię chłopak Barbary nazywany "nauczycielem"?'
        context_crumbs = Context::KnowledgeCollector.new(issue: question, warehouse:).find_related_data_crumbs(limit: 10)
        context = context_crumbs.map(&:content).join('\n')

        message = 'Based on the given conversation and context. Answer to the following question:\n'
        message += "<conversation>\n#{conversation}\n</conversation>\n"
        message += "<context>\n#{context}\n</context>\n"
        message += "<question>\n#{question}\n</question>\n"

        chat(message)[:content]
      end
    end
  end
end

# AiDevs3::Exercises::Phone.new.prepare_data_crumbs_with_facts
# AiDevs3::Exercises::Phone.new.answer
# AiDevs3::Exercises::Phone.new(destination_link: 'https://centrala.ag3nts.org/report', task: 'PHONE').send_answer
