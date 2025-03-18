module AiDevs3
  module Exercises
    module Prompts
      module Webhooks
        class ObtainInstructions < AiDevs3::Exercises::Prompts::BasePrompt
          private
          def prompt_source_yml
            YAML.load_file(File.join(__dir__, 'obtain_instructions.yml'))
          end
        end
      end
    end
  end
end

# AiDevs3::Exercises::Prompts::Webhooks::ObtainInstructions.new.prompt
