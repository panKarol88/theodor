# frozen_string_literal: true

module Theodor
  module V1
    module Prompts
      class API < Theodor::V1::API
        resource :prompts do
          mount Theodor::V1::Prompts::Question
          mount Theodor::V1::Prompts::Prompt
        end
      end
    end
  end
end
