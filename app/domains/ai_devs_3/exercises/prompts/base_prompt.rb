module AiDevs3
  module Exercises
    module Prompts
      class BasePrompt
        def initialize(**args)
          @args = args
        end

        def prompt
          prompt_body = ''
          prompt_source_yml.each do |key, value|
            paragraph = key == 'entry' ? "#{value}\n\n" : "<#{key}>\n#{value}\n</#{key}>\n"
            prompt_body << paragraph
          end

          prompt_body
        end

        private

        attr_reader :args

        def prompt_source_yml
          raise NotImplementedError
        end
      end
    end
  end
end
