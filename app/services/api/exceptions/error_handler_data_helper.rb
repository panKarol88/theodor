# frozen_string_literal: true

module API
  module Exceptions
    module ErrorHandlerDataHelper
      def api_standard_error_data
        { message: exception.message }
      end

      def record_invalid_data
        record = exception.record
        return {} unless record

        {
          record_type: record.class.name,
          attributes: record_invalid_data_attributes(record)
        }
      end

      private

      # it looks clean and simple to have it all nested in one place
      # :reek:NestedIterators
      def record_invalid_data_attributes(record)
        record.errors.group_by(&:attribute).transform_values do |errors|
          errors.map do |error|
            {
              default_error_message: error.message,
              options: error.options.except(:value)
            }
          end
        end
      end
    end
  end
end
