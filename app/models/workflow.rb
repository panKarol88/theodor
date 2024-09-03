# frozen_string_literal: true

class Workflow < ApplicationRecord
  include Helpers::ValidationHelper

  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase

  belongs_to :user
  has_many :workflows_features, dependent: :destroy
  has_many :features, through: :workflows_features
end
