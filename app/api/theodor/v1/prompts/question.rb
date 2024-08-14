# frozen_string_literal: true

module Theodor
  module V1
    module Prompts
      class Question < API
        resource :question do
          desc 'Ask Theodor a question.'

          params do
            requires :question, type: String, desc: 'Question.'
          end

          helpers do
            def question
              @question ||= params[:question]
            end
          end

          post do
            AiFeatures::Knowledge.new(input: question, warehouse:, feature:).process
          end
        end
      end
    end
  end
end
