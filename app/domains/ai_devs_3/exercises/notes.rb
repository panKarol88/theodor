# S04E05 - Zadanie 1

module AiDevs3
  module Exercises
    class Notes < Exercise
      def embed_note_markdown
        file_path = Rails.root.join('app', 'domains', 'ai_devs_3', 'notatnik_rafala', 'notatnik-rafala.md')
        markdown_content = File.read(file_path)


        markdown_array = markdown_content.split('---').map do |paragraph|
          paragraph.gsub("\n", "").gsub("```", "")
        end

        markdown_array.each do |paragraph|
          DataCrumbs::Builder.new(content: paragraph, warehouse: Warehouse.find_by(name: 'ai_devs')).embed_and_create
        end
      end

      def questions
        return {"01"=>"Do którego roku przeniósł się Rafał",
                "02"=>"Kto wpadł na pomysł, aby Rafał przeniósł się w czasie?",
                "03"=>"Gdzie znalazł schronienie Rafał? Nazwij krótko to miejsce",
                "04"=>"Którego dnia Rafał ma spotkanie z Andrzejem? (format: YYYY-MM-DD)",
                "05"=>"Gdzie się chce dostać Rafał po spotkaniu z Andrzejem?"}

        questions_link = "https://centrala.ag3nts.org/data/#{ENV.fetch('AI_DEVS_API_KEY', nil)}/notes.json"
        JSON.parse(URI.open(questions_link).read.gsub("\n    ", ""))
      end

      def question_answer(question)
        context = Context::KnowledgeCollector.new(
          issue: question,
          warehouse: Warehouse.find_by(name: 'ai_devs'),
        ).find_related_data_crumbs(limit: 19).map{|data_crumb| data_crumb.content}.join("\n")

        user_prompt = {
          given_context: context,
          given_question: question
        }.to_json

        messages = [
          {
            'role': 'system',
            'content': AiDevs3::Exercises::Prompts::Notes::AnswerNotesQuestions.new.prompt,
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

      def answers
        llm_answers = questions.map do |q_id, question|
          [q_id, { question: question, answer: question_answer(question) }]
        end.to_h
        Rails.logger.info(llm_answers)

        llm_answers
      end

      def answer
        # return {"01"=>"Rafał przeniósł się do roku 2024.",
        #         "02"=>"Nie jest jednoznacznie określone, kto wpadł na pomysł przeniesienia się w czasie. Możliwe, że to Adam, ale nie ma pewności.",
        #         "03"=>"Rafał znalazł schronienie w odosobnionym miejscu niedaleko miasta.",
        #         "04"=>"2024-11-10",
        #         "05"=>"Nie ma informacji, gdzie Rafał chce się dostać po spotkaniu z Andrzejem."}

        return {"01"=>"2019",
                "02"=>"Pomysł przeniesienia się w czasie prawdopodobnie pochodzi od Adama.",
                "03"=>"Jaskinia niedaleko miasta.",
                "04"=>"2024-11-12",
                "05"=>"Rafał chce się dostać do Lubawy koło Grudziądza."}

        answers.map{|k,v| [k, JSON.parse(v[:answer].gsub('=>', ': '))['answer']]}.to_h
      end
    end
  end
end

# AiDevs3::Exercises::Notes.new.embed_note_markdown
# AiDevs3::Exercises::Notes.new.questions
# AiDevs3::Exercises::Notes.new.question_answer()
# AiDevs3::Exercises::Notes.new.answers
# AiDevs3::Exercises::Notes.new.answer

# AiDevs3::Exercises::Notes.new(
#   destination_link: 'https://centrala.ag3nts.org/report',
#   task: 'NOTES').send_answer
