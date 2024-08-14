# frozen_string_literal: true

class Feature < ApplicationRecord
  include Helpers::ValidationHelper

  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase

  has_many :prompt_decorators, dependent: :destroy
  has_and_belongs_to_many :warehouses

  def process(input, warehouse)
    Features::Feature.new(feature_record: self, input:, warehouse:).process
  end
end
