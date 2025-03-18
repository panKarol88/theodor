# S01E05 - Zadanie 1

module AiDevs3
  module Exercises
    class Dokumenty < Exercise
      def file_dirs
        @file_dirs ||= begin
                         dir = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki')
                         file_names = Dir.entries(dir).select { |f| !File.directory? f }
                         file_names.select { |f| f.match(/\.txt/) }
                       end.select{|dir| dir.split('.').count == 2 }
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

      def answer
        return {"2024-11-12_report-05-sektor_C1.txt"=>
                  "aktywnosc, sensor, detektory, patrol, monitorowanie, Aleksander Ragowski, nauczyciel, automatyzacja, rząd robotów, krytyka, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Adam Gospodarczyk, ruch oporu, rekrutacja, kodowanie, hackowanie, Azazel, podróżnik w czasie i przestrzeni, technologia przyszłości, szkolenie, agenci, sztuczna inteligencja",
                "2024-11-12_report-03-sektor_A3.txt"=>
                  "patrole, czujniki, życie organiczne, Aleksander Ragowski, nauczyciel, automatyzacja, rząd robotów, krytyka, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Adam Gospodarczyk, ruch oporu, rekrutacja, kodowanie, Azazel, podróżnik w czasie i przestrzeni, technologia przyszłości, hackowanie, agenci, zabezpieczenia AI, szkolenie, sabotaż, reżim sztucznej inteligencji.",
                "2024-11-12_report-06-sektor_C2.txt"=>
                  "godzina, sektor, skanery, jednostka, patrol, Aleksander Ragowski, nauczyciel, język angielski, Szkoła Podstawowa nr 9, Grudziądz, automatyzacja, rząd robotów, krytyk, reżim, spotkania, edukacja, algorytmy, sztuczna inteligencja, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Barbara Zawadzka, frontend development, IT, firma, maszyny, ruch oporu, JavaScript, Python, AI Devs, bazy wektorowe, kodowanie, Kraków, ul. Bracka, związek, krav maga, samoobrona, broń palna, koktajle Mołotowa, zamieszki, sabotaż, pizza z ananasem.",
                "2024-11-12_report-00-sektor_C4.txt"=>
                  "jednostka organiczna, Aleksander Ragowski, skan biometryczny, dział kontroli, nauczyciel języka angielskiego, Szkoła Podstawowa nr 9, Grudziądz, automatyzacja, rząd robotów, krytyk reżimu, tajne spotkania, edukacja, algorytmy, sztuczna inteligencja, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Rafał Bomba, laborant, ośrodek badawczy, profesor Andrzej Maj, podróże w czasie, nanotechnologia, zaginięcie, fałszywe nazwisko Musk, zaburzenia psychiczne, wizje technologii przyszłości, paranoja, ludzki z przyszłości, eksperymenty manipulacji umysłowej.",
                "2024-11-12_report-04-sektor_B2.txt"=>
                  "patrol, teren, anomalia, sektor, kanały komunikacyjne, Adam Gospodarczyk, ruch oporu, programowanie, rekrutacja, technologia, kodowanie, agenci, reżim sztucznej inteligencji, Azazel, podróżnik w czasie i przestrzeni, hackowanie, szkolenie, bypassowanie zabezpieczeń AI, rekruci, władze, sieć powiązań, struktury rządowe, Aleksander Ragowski, nauczyciel języka angielskiego, automatyzacja, rząd robotów, krytyka reżimu, aresztowanie, ucieczka, programowanie Java, edukacja.",
                "2024-11-12_report-01-sektor_A1.txt"=>
                  "alarm, ruch organiczny, zwierzyna leśna, Aleksander Ragowski, nauczyciel, język angielski, Grudziądz, automatyzacja, rząd robotów, krytyka, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Barbara Zawadzka, frontend development, IT, sztuczna inteligencja, ruch oporu, JavaScript, Python, AI Devs, bazy wektorowe, Kraków, ul. Bracka, krav maga, broń palna, koktajle Mołotowa, pizza z ananasem",
                "2024-11-12_report-02-sektor_A3.txt"=>
                  "patrol, monitoring, Aleksander Ragowski, nauczyciel, automatyzacja, rząd robotów, krytyka, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Adam Gospodarczyk, ruch oporu, rekrutacja, kodowanie, Azazel, podróżnik w czasie i przestrzeni, technologia przyszłości, hackowanie, szkolenie, agenci, sztuczna inteligencja",
                "2024-11-12_report-07-sektor_C4.txt"=>
                  "C4, sektor C4, Godzina, czujniki dźwięku, ultradźwiękowy sygnał, nadajnik, krzaki, las, analiza, odciski palców, Barbara Zawadzka, baza urodzeń, dział śledczy, obszar zabezpieczony, patrol, incydenty, bojownicy ruchu oporu, władza, frontend development, kariera IT, automatyzacja, sztuczna inteligencja, reżim, JavaScript, Python, AI Devs, bazy wektorowe, systemy rządowe, kontrola robotów, Aleksander Ragorski, nauczyciel angielskiego, Kraków, ul. Bracka, automatyzacja, krav maga, samoobrona, broń palna, koktajle Mołotowa, zamieszki, sabotażowe akcje, pizza z ananasem, równowaga psychiczna, miasta o ograniczonym dostępie, komunikacja SI, Rafał Bomba, laborant, ośrodek badawczy, profesor Andrzej Maj, podróże w czasie, nanotechnologia, ambicje naukowe, zaginięcie Rafała, fałszywe nazwisko Musk, zaburzenia psychiczne, wizje technologii przyszłości, paranoja technologiczna, ośrodek dla obłąkanych, manipulacja umysłowa.",
                "2024-11-12_report-08-sektor_A1.txt"=>
                  "monitoring, cisza, czujniki, Aleksander Ragowski, nauczyciel, język angielski, Grudziądz, automatyzacja, rząd robotów, krytyka, aresztowanie, ucieczka, programowanie, Java, opozycja, systemy rządowe, Barbara Zawadzka, frontend development, IT, sztuczna inteligencja, ruch oporu, JavaScript, Python, AI Devs, bazy wektorowe, Kraków, ul. Bracka, krav maga, broń palna, koktajle Mołotowa, pizza z ananasem.",
                "2024-11-12_report-09-sektor_C2.txt"=>
                  "patrol, peryferie, czujniki, anomalia, cykl, sektor, Aleksander Ragowski, nauczyciel, język angielski, Szkoła Podstawowa nr 9, Grudziądz, automatyzacja, rząd robotów, krytyka, reżim, spotkania tajne, algorytmy, sztuczna inteligencja, aresztowanie, ucieczka, programowanie, Java, opozycja, zabezpieczenia systemów rządowych, Rafał Bomba, laborant, ośrodek badawczy, profesor Andrzej Maj, eksperymenty tajne, podróże w czasie, nanotechnologia, zaginięcie, nazwisko fałszywe \"Musk\", zaburzenia psychiczne, wizje technologii przyszłości, paranoja, ludzie z przyszłości, urządzenia modyfikujące pamięć, manipulacja umysłowa."}

        summary = {}

        file_dirs.each do |file_name|
          file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'pliki_z_fabryki', file_name)
          content = File.open(file_path, 'r') { |file| file.read }

          context_crumbds = Context::KnowledgeCollector.new(issue: content, warehouse: Warehouse.find_by(name: 'ai_devs')).find_related_data_crumbs(limit: 2)
          context = context_crumbds.map(&:content).join('\n')

          message = 'Interpret the text and return a list of keywords that describes the text.\n'
          message += '<text>\n'
          message += "#{content}\n"
          message += "#{context}\n"
          message += '</text>'
          message += '<example>\n'
          message += 'input: Móje ulubione ciasto, to szarlotka. Oto przepis na szarlotkę: jajka, mąkę i cukier umieść w misie i wymieszaj. Następnie dodaj jabłka i piecz przez 30 minut. Jarek bardzo lubi ten przepis. Zostawia w kuchni wiele odcisków palców.\n'
          message += 'output: ciasto, szarlotka, przepis, jarek, kuchnia, odciski palców\n'
          message += '</example>\n'
          message += 'Return only the keyword list and nothing else.'
          message += 'Return keywords in polish in \'mianownik\'.'

          p '------------------------------------------------------'
          p '######################################################'
          p content
          p '---'
          p context
          p '######################################################'
          p '------------------------------------------------------'

          summary[file_name] = chat(message)[:content]
        end

        summary
      end
    end
  end
end

# AiDevs3::Exercises::Dokumenty.new.answer

# AiDevs3::Exercises::Dokumenty.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'DOKUMENTY').send_answer
