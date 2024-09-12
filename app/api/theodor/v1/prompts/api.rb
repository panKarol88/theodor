# frozen_string_literal: true

module Theodor
  module V1
    module Prompts
      class API < Theodor::V1::API
        resource :prompt do
          mount Theodor::V1::Prompts::Prompt
        end
      end
    end
  end
end
