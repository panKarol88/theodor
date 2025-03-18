module AiDevs3
  module Exercises
    module Prompts
      module Webhooks
        class MapDescription < AiDevs3::Exercises::Prompts::BasePrompt
          private
          def prompt_source_yml
            YAML.load_file(File.join(__dir__, 'map_description.yml'))
          end
        end
      end
    end
  end
end

# AiDevs3::Exercises::Prompts::Webhooks::MapDescription.new.prompt
