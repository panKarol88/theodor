# frozen_string_literal: true

module LlmTools
  class VisionInfo
    def submit(prompt:, vision_sources:)
      OpenAi::Client.new.vision_info(prompt:, vision_sources:)['choices'][0]
    end
  end
end
