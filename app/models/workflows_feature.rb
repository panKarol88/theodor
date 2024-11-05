# frozen_string_literal: true

class WorkflowsFeature < ApplicationRecord
  PROPERTIES_ALLOWED = %w[probability_threshold resource_class].freeze

  belongs_to :workflow
  belongs_to :feature

  validate :validate_properties

  scope :priority_ordered, -> { order(:priority) }

  private

  def validate_properties
    invalid_keys = properties.keys - PROPERTIES_ALLOWED
    if invalid_keys.any?
      errors.add(:properties, "contains invalid properties: #{invalid_keys.join(', ')}")
    end
  end
end
