# frozen_string_literal: true

module Theodor
  module V1
    module Prompts
      class API < Theodor::V1::API
        helpers ::Theodor::Helpers::KnowledgeAPI

        resource :prompts do
          mount Theodor::V1::Prompts::Question
        end
      end
    end
  end
end
