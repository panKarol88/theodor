# frozen_string_literal: true

module Features
  class ProbabilityFeature < Feature
    private

    def obtain_response
      return unless thread_object[:probability] < feature_properties[:probability_threshold].to_f

      thread_object[:stop_processing] = true
      chat(prompt)
    end

    def probability_properties
      thread_object[:thread_log].last[:feature_properties]
    end
  end
end
