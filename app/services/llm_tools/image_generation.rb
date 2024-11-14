# frozen_string_literal: true

module LlmTools
  class ImageGeneration
    def submit(prompt:, size:)
      OpenAi::Client.new.image_generation(prompt:, size:)
    end
  end
end
