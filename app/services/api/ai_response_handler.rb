# frozen_string_literal: true

module API
  class AiResponseHandler
    def initialize(prompt_object:)
      @prompt_object = prompt_object
    end

    def presenter_stack
      case prompt_object
      when DataCrumb
        [prompt_object, Theodor::Entities::DataCrumb::DataCrumb]
      else
        [prompt_object, nil]
      end
    end

    private

    attr_reader :prompt_object
  end
end
