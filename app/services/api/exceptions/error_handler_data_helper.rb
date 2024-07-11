# frozen_string_literal: true

module API
  module Exceptions
    module ErrorHandlerDataHelper
      VALIDATION_KEY_PREFIX = 'record_invalid'

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
              error_translation_key: "#{VALIDATION_KEY_PREFIX}.#{error.type}",
              options: error.options.except(:value)
            }
          end
        end
      end
    end
  end
end
