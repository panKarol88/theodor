# frozen_string_literal: true

module Rupert
  module V1
    module Prompts
      class API < Rupert::V1::API
        resource :prompt do
          mount Rupert::V1::Prompts::Prompt
        end
      end
    end
  end
end
