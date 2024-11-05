module Shared
  class AnswerGenerator
    include ::Helpers::LlmInterface

    def initialize(content:, probability:, probability_threshold:)
      @content = content
      @probability = probability
      @probability_threshold = probability_threshold
    end

    def generate_answer
      if probability > probability_threshold.to_f
        content
      else
        chat("Describe that you think that the correct answer is the following: \"#{content}\", but you are not so sure about it.")[:content]
      end
    end

    private

    attr_reader :content, :probability, :probability_threshold
  end
end
