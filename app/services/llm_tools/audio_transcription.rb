# frozen_string_literal: true

module LlmTools
  class AudioTranscription
    def submit(file_dir:)
      raw_response = OpenAi::Client.new.audio_transcription(file_dir:)
      raw_response['text']
    rescue NoMethodError => error
      Rails.logger.error("### OpenAi::Client ###\n #{raw_response}\nAudioTranscription error: #{error.message}")
    end
  end
end
