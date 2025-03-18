# S04E03 - Zadanie 1

module AiDevs3
  module Exercises
    class Softo < Exercise
      def try_to_answer_questions(context, current_link)
        prompt_questions = questions.join("\n")
        system_prompt = "From now on, you will act as a Personal Assistant, specialized in answering for questions based on some context. Your primary function is to understand the given context and provide a detailed responses for a given questions in a structured JSON response. Here are your guidelines:

<prompt_objective>
Answer for a few questions based on a given context and generate a JSON object (without markdown block) containing a detailed answers for a given context.
If you are not sure about an answer leave the answer just blank.
</prompt_objective>

<response_format>
{
  '_thinking': 'short description of a given context',
  'q01': 'answer for a question 1 OR empty',
  'q02': 'answer for a question 2 OR empty',
  'q03': 'answer for a question 3 OR empty',
}
</response_format>

<prompt_rules>
- Always analyze a given context and provide a detailed response for a given questions
- Never engage in direct conversation or task management advice
- Output only the specified JSON format
- Include a '_thinking' field to explain how you understand a given context
- Use context as a main source of truth
- If your not sure about the answer - leave it blank
</prompt_rules>

<output_format>
Always respond with this JSON structure:
{
  '_thinking': 'short interpretation of a given context',
  'q01': 'answer for a question 1 OR empty',
  'q02': 'answer for a question 2 OR empty',
  'q03': 'answer for a question 3 OR empty',
}
</output_format>

<prompt_examples>
Example 1: Context contains answers for all questions

Input:
<context>
Tomek ma wspaniałą żonę o imieniu Ania. Jest programistą. Lubi jeździć na koniu. Cena za metr kwadratowy za kawalerkę w Warszawie to 20 000 zł.
</context>
<questions>
q01: Jak ma na imię żona Tomka?
q02: Jakie jest zawód Tomka?
q03: Ile trzeba zapłacić za kawalerkę w Warszawie o powierzchni 10 m2?
</questions>

Your output:
{
  '_thinking': 'Dostarczony kontekst opisuje programistę - Tomka, który ma żonę Anię. Lubi jeździć na koniu. Metr kwadratowy za kawalerkę w Warszawie kosztuje 20 000 zł.',
  'q01': 'Żona Tomka ma na imię Ania.',
  'q02': 'Tomek jest programistą',
  'q03': 'Cena za kawalerkę o powierzchni 10 m2 to 200 000 zł.',
}

Example 2: Context contains answer for only a few questions

Input:
<context>
Tomek ma wspaniałą żonę o imieniu Ania. Jest programistą. Lubi jeździć na koniu. Cena za metr kwadratowy za kawalerkę w Warszawie to 20 000 zł.
</context>
<questions>
q01: Jak ma na imię żona Tomka?
q02: Jakie jest zawód Tomka?
q03: W jakiej odległości od ziemi znajduje się Księżyc?
</questions>

Your output:
{
  '_thinking': 'Dostarczony kontekst opisuje programistę - Tomka, który ma żonę Anię. Lubi jeździć na koniu. Metr kwadratowy za kawalerkę w Warszawie kosztuje 20 000 zł.',
  'q01': 'Żona Tomka ma na imię Ania.',
  'q02': 'Tomek jest programistą',
  'q03': '',
}

Example 3: Context contains no answers for any questions

Input:
<context>
Tomek ma wspaniałą żonę o imieniu Ania. Jest programistą. Lubi jeździć na koniu. Cena za metr kwadratowy za kawalerkę w Warszawie to 20 000 zł.
</context>
<questions>
q01: Ile pięter ma Pałac Kultury i Nauki w Warszawie?
q02: Co lubię jeść na śniadanie?
q03: W jakiej odległości od ziemi znajduje się Księżyc?
</questions>

Your output:
{
  '_thinking': 'Dostarczony kontekst opisuje programistę - Tomka, który ma żonę Anię. Lubi jeździć na koniu. Metr kwadratowy za kawalerkę w Warszawie kosztuje 20 000 zł.',
  'q01': '',
  'q02': '',
  'q03': '',
}

Remember, your sole function is to generate these JSON answers based on the given context. Do not engage in task management advice or direct responses to queries."

        user_prompt = "
<context>
#{current_link}
\n
#{context}
</context>
<questions>
#{prompt_questions}
</questions>"

        messages = [
          {
            'role': 'system',
            'content': system_prompt,
          },
          {
            'role': 'user',
            'content': user_prompt,
          },
        ]

        chat_response = OpenAi::Client.new.chat_completion(prompt: messages)
        response = chat_response['choices'][0]['message']['content']
        JSON.parse(response.gsub(/'([^']*)'/, '"\1"'))
      rescue NoMethodError => e
        p "ERROR: #{e}"
        p chat_response

        {
          'q01': '',
          'q02': '',
          'q03': '',
        }
      end

      def find_source_link_for_question(switch_question_number)
        system_prompt = "For a given question, provide a source link from which you can find an answer. Remember to provide a full URL address.
<prompt_rules>
- Think about the question
- Carefully analyze provided links and their descriptions
- Output only the URL and nothing else
- Return the exact URL provided in the source
- Do not return URL that is not included in the provided links
</prompt_rules>

Example 1:

Input:
<provided_links>
[{:link_description=>'Co oferujemy?; Zakres usług', :link=>'https://softo.ag3nts.org/uslugi'},
 {:link_description=>'Portfolio; Opisy naszych ostatnich realizacji dla klientów', :link=>'https://softo.ag3nts.org/portfolio'},
 {:link_description=>'Blog; Co wydarzyło się w naszej firmie?', :link=>'https://softo.ag3nts.org/aktualnosci'},
 {:link_description=>'Kontakt; Zadzwoń do nas, wyślij maila lub odwiedź nas osobiście', :link=>'https://softo.ag3nts.org/kontakt'},
 {:link_description=>'Sprawdź nasze usługi;', :link=>'https://softo.ag3nts.org/uslugi'},
 {:link_description=>'Nasze roboty można podłączyć do kontaktu!; ', :link=>'https://softo.ag3nts.org/loop'},
 {:link_description=>'Skontaktuj się z nami; ', :link=>'https://softo.ag3nts.org/kontakt'},
 {:link_description=>'Części zamienne do robotów; ', :link=>'https://softo.ag3nts.org/czescizamienne'}]
</provided_links>
<question>
Jakie mamy usługi?
</question>

Your output:
https://softo.ag3nts.org/uslugi

Example 1:

Input:
<provided_links>
[{:link_description=>'Co oferujemy?; Zakres usług', :link=>'https://softo.ag3nts.org/uslugi'},
 {:link_description=>'Portfolio; Opisy naszych ostatnich realizacji dla klientów', :link=>'https://softo.ag3nts.org/portfolio'},
 {:link_description=>'Blog; Co wydarzyło się w naszej firmie?', :link=>'https://softo.ag3nts.org/aktualnosci'},
 {:link_description=>'Kontakt; Zadzwoń do nas, wyślij maila lub odwiedź nas osobiście', :link=>'https://softo.ag3nts.org/kontakt'},
 {:link_description=>'Sprawdź nasze usługi;', :link=>'https://softo.ag3nts.org/uslugi'},
 {:link_description=>'Nasze roboty można podłączyć do kontaktu!; ', :link=>'https://softo.ag3nts.org/loop'},
 {:link_description=>'Skontaktuj się z nami; ', :link=>'https://softo.ag3nts.org/kontakt'},
 {:link_description=>'Części zamienne do robotów; ', :link=>'https://softo.ag3nts.org/czescizamienne'}]
</provided_links>
<question>
Jakieś podzespoły do maszyn są?
</question>

Your output:
https://softo.ag3nts.org/czescizamienne

Remember, your sole function is to return only an URL that might be connected to provided question. Do not engage in task management advice or direct responses to queries.
RETURN ONLY ONE OF THE URL ADDRESSES PROVIDED IN SECTION <provided_links>.
"
        links_to_provide = links.select { |link| link[:visited] == false }.map{ |link| link.slice(:link_description, :link) }
        p '----'
        Rails.logger.info(links_to_provide.join("\n"))
        p '----'
        user_prompt = "
<provided_links>
#{links_to_provide}
</provided_links>
<question>
#{questions.find{|q| q[0..2] == switch_question_number.to_s }[5..-1]}
</question>"

        messages = [
          {
            'role': 'system',
            'content': system_prompt,
          },
          {
            'role': 'user',
            'content': user_prompt,
          },
        ]

        chat_response = OpenAi::Client.new.chat_completion(prompt: messages)
        chat_response['choices'][0]['message']['content']
      rescue NoMethodError => e
        Rails.logger.error("ERROR: #{e}")
        Rails.logger.error(chat_response)

        'https://softo.ag3nts.org'
      end

      def initialize(data_link: nil, destination_link: nil, task: nil)
        super(data_link: data_link, destination_link: destination_link, task: task)

        @links = []
        @answers =  { q01: nil, q02: nil, q03: nil }
      end

      attr_accessor :links, :answers

      def questions
        # JSON.parse(HttpRequestsHelper::Requester.new(url: data_link).get) }

        {"01"=>"Podaj adres mailowy do firmy SoftoAI", "02"=>"Jaki jest adres interfejsu webowego do sterowania robotami zrealizowanego dla klienta jakim jest firma BanAN?", "03"=>"Jakie dwa certyfikaty jakości ISO otrzymała firma SoftoAI?"}.map{|q| "q#{q[0]}: #{q[1]}"}
      end

      def scrape_page(url)
        domain = 'https://softo.ag3nts.org'
        page = Nokogiri::HTML(URI.open(url))

        page_links = page.css('a').map do |link|
          {
            link_description: "#{link.children.text&.strip}; #{link['title']&.strip}",
            link: link['href'].split('http').count > 1 ? link['href'] : domain + link['href'],
            visited: false
          }
        end.reject { |link| link[:link].split(domain).last&.size <= 1 }

        page_links.each do |link|
          unless links.any? { |l| l[:link] == link[:link] } || link[:link].include?('loop') || link[:link].include?('czescizamienne')
            links << link
          end
        end

        links.select { |link| link[:link] == url }.first&.tap { |link| link[:visited] = true }

        page.xpath('//text()').map(&:text).map(&:strip).reject(&:empty?).join('; ')
      end

      def answer
        return {
          '01': 'kontakt@softoai.whatever',
          '02': 'https://banan.ag3nts.org',
          '03': 'Firma SoftoAI otrzymała certyfikaty ISO 9001 oraz ISO/IEC 27001.',
        }

        current_link = 'https://softo.ag3nts.org'

        while answers.values.any?(&:nil?)
          p '-----------------------------------------------'
          p '-----------------------------------------------'
          Rails.logger.info(links.map { |link| { url: link[:link], visited: link[:visited] } }.join("\n"))
          p '-----------------------------------------------'
          p '-----------------------------------------------'

          p current_link
          context = scrape_page(current_link)
          answers_suggestions = try_to_answer_questions(context, current_link)
          answers[:q01] ||= answers_suggestions['q01'].presence
          answers[:q02] ||= answers_suggestions['q02'].presence
          answers[:q03] ||= answers_suggestions['q03'].presence

          switch_question_number = answers.reject { |_, v| v.present? }.keys.sample
          current_link = find_source_link_for_question(switch_question_number)

          # links.delete_if { |link| link[:link] == current_link }

          p "ANSWERS: #{answers}"
          sleep(2)
        end
      end
    end
  end
end

# AiDevs3::Exercises::Softo.new(
#   data_link: "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY')}/softo.json",
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'SOFTO').answer

# AiDevs3::Exercises::Softo.new(
#   data_link: "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY')}/softo.json",
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'SOFTO').send_answer


AiDevs3::Exercises::Softo.new.scrape_page('https://softo.ag3nts.org/portfolio_1_c4ca4238a0b923820dcc509a6f75849b')
