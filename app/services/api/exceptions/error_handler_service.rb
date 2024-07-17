# frozen_string_literal: true

module API
  module Exceptions
    class ErrorHandlerService
      include ::API::Exceptions::ErrorHandlerDataHelper

      def initialize(exception:)
        @exception = exception
      end

      def error_attributes
        { payload:, error_status: }
      end

      private

      attr_accessor :exception, :status

      def error_data
        case exception
        when ::API::Exceptions::APIStandardError, Grape::Exceptions::ValidationErrors
          api_standard_error_data
        when ActiveRecord::RecordInvalid
          record_invalid_data
        when ActiveRecord::RecordNotFound
          @status = :not_found
          api_standard_error_data
        else
          { message: exception.try('message') }
        end
      end

      def payload
        {
          error_type: exception.class.name&.split('::')&.last,
          error_data:,
          backtrace: exception.backtrace
        }
      end

      def error_status
        error_status = @status || exception.try('status') || :unprocessable_entity

        error_status = Rack::Utils::SYMBOL_TO_STATUS_CODE[error_status] if error_status.is_a?(Symbol)
        error_status
      end
    end
  end
end
