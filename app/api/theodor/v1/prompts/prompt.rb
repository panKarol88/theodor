# frozen_string_literal: true

module Theodor
  module V1
    module Prompts
      class Prompt < API
        desc 'Process general prompt.'

        helpers ::Theodor::Helpers::PromptAPI

        post do
          Workflows::WorkflowHandler.new(workflow:).process_input(input:)[:output]
        end
      end
    end
  end
end
