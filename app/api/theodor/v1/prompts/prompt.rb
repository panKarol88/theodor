# frozen_string_literal: true

module Theodor
  module V1
    module Prompts
      class Prompt < API
        desc 'Process general prompt.'

        helpers ::Theodor::Helpers::KnowledgeAPI

        helpers do
          def prompt_object
            @prompt_object ||= AiFeatures::Knowledge.new(user: current_user, input:, warehouse:, feature:).process
          end
        end

        post do
          object_payload
        end
      end
    end
  end
end
