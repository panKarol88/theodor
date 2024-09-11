# frozen_string_literal: true

class PromptDecorator < ApplicationRecord
  include Helpers::ValidationHelper

  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase
  validates :value, presence: true
  validates :priority, presence: true, uniqueness: { scope: :feature_id }

  belongs_to :feature

  scope :priority_ordered, -> { order(:priority) }
end
