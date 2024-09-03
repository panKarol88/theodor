# frozen_string_literal: true

class WorkflowsFeature < ApplicationRecord
  belongs_to :workflow
  belongs_to :feature

  scope :priority_ordered, -> { order(:priority) }
end
