# frozen_string_literal: true

module API
  module Exceptions
    class APIStandardError < StandardError
      attr_reader :status, :message

      def initialize(status:, message:)
        @status = status
        @message = message

        super
      end
    end
  end
end
