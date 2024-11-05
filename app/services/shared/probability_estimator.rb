module Shared
  class ProbabilityEstimator
    def initialize(logprobs_tokens:)
      @logprobs_tokens = logprobs_tokens
    end

    def count_probability
      sanitize_json_tokens
      sanitize_special_characters

      logprobs_tokens.sum { |token| Math.exp(token['logprob']) } / logprobs_tokens.size
    end

    private

    attr_reader :logprobs_tokens

    # reject all tokens that are valid JSON keys
    # probability for these tokens is irrelevant
    def sanitize_json_tokens
      joined_tokens = logprobs_tokens.map { |logprobs_token| logprobs_token['token'] }.join
      json_response = JSON.parse(joined_tokens)
      keys = json_response.keys
      logprobs_tokens.reject! { |token| keys.include?(token['token']) }
    rescue JSON::ParserError, NoMethodError
      nil # if the JSON is invalid, do nothing
    end

    # select only tokens that contain letters and numbers
    # probability for special characters is irrelevant
    def sanitize_special_characters
      logprobs_tokens.select! { |token| token['token'] =~ /\A[a-zA-Z0-9]+\z/ }
    end
  end
end
