# frozen_string_literal: true

module Theodor
  module Helpers
    module ErrorHandler
      def handle_exception(exception)
        Rails.logger.error(exception.message)
        error_attributes = ::API::Exceptions::ErrorHandlerService.new(exception:).error_attributes

        error!(error_attributes[:payload], error_attributes[:error_status])
      end

      # TODO
      # consider to split it to several different errors
      # AuthorizationError < APIStandardError
      # TokenError < APIStandardError
      # etc.
      def raise_api_error!(message, status)
        raise ::API::Exceptions::APIStandardError.new(status:, message:)
      end
    end
  end
end
