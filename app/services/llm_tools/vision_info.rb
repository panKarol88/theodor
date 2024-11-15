# frozen_string_literal: true

module LlmTools
  class VisionInfo
    def submit(prompt:, vision_sources:)
      raw_response = OpenAi::Client.new.vision_info(prompt:, vision_sources:)
      raw_response['choices'][0]
    rescue NoMethodError => error
      Rails.logger.error("### OpenAi::Client ###\n #{raw_response}\nVisionInfo error: #{error.message}")
    end
  end
end
