# frozen_string_literal: true

class PromptDecorator < ApplicationRecord
  include Helpers::ValidationHelper

  validates :value, presence: true
  validates :name, presence: true, uniqueness: true
  validates :priority, presence: true, uniqueness: { scope: :feature_id }
  validate :name_is_snakecase

  belongs_to :feature

  scope :priority_ordered, -> { order(:priority) }
end
