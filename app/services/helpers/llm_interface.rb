# frozen_string_literal: true

module Helpers
  module LlmInterface
    def embed(input)
      LlmTools::Embedding.new(input:).embed
    end

    def chat(prompt:, model: 'gpt-4o-mini')
      choice = LlmTools::Chat.new.submit(prompt:, model:)
      response_object(choice)
    end

    def vision_info(prompt, vision_sources)
      choice = LlmTools::VisionInfo.new.submit(prompt:, vision_sources:)
      response_object(choice)
    end

    def image_generation(prompt, size = '1024x1024')
      LlmTools::ImageGeneration.new.submit(prompt:, size:)
    end

    def audio_transcription(file_dir)
      LlmTools::AudioTranscription.new.submit(file_dir:)
    end

    def resource_bet(prompt)
      choice = LlmTools::ResourceBet.new.submit(prompt:)
      response_object(choice)
    end

    private

    def response_object(choice)
      content = choice.dig('message', 'content')
      logprobs_tokens = choice.dig('logprobs', 'content')
      probability = Shared::ProbabilityEstimator.new(logprobs_tokens:).count_probability

      { content:, probability: }
    end
  end
end
