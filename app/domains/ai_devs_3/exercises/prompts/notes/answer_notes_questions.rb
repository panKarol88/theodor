module AiDevs3
  module Exercises
    module Prompts
      module Notes
        class AnswerNotesQuestions < AiDevs3::Exercises::Prompts::BasePrompt
          private
          def prompt_source_yml
            YAML.load_file(File.join(__dir__, 'answer_notes_questions.yml'))
          end
        end
      end
    end
  end
end

# AiDevs3::Exercises::Prompts::Notes::AnswerNotesQuestions.new.prompt
