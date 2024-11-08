require 'open-uri'
require 'selenium-webdriver'

module AiDevs3
  module Exercises
    class Exercise
      include HttpRequestsHelper
      include Helpers::LlmInterface

      def initialize(data_link: nil, destination_link: nil, task: nil)
        @data_link = data_link
        @destination_link = destination_link
        @task = task
      end

      def result
        {
          "task": task,
          "apikey": ENV.fetch('AI_DEVS_API_KEY', nil),
          "answer": answer
        }.to_json
      end

      def send_answer
        p send_post_request(destination_link, result)
      end

      attr_reader :data_link, :destination_link, :task

      def answer
        raise NotImplementedError
      end
    end
  end
end
