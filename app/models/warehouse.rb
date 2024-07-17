# frozen_string_literal: true

class Warehouse < ApplicationRecord
  include Helpers::ValidationHelper

  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase

  has_many :data_crumbs, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :prompt_decorators
end
