# frozen_string_literal: true

class Feature < ApplicationRecord
  include Helpers::ValidationHelper

  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase

  has_many :prompt_decorators, dependent: :destroy
  has_many :workflows_features, dependent: :destroy
  has_many :workflows, through: :workflows_features
  has_and_belongs_to_many :warehouses

  scope :priority_ordered, -> { order(:priority) }

  def process(input:, warehouse: nil)
    feature_service.new(feature_record: self, input:, warehouse:).process
  end

  def resourceable?
    prompt_decorators.any? do |prompt_decorator|
      prompt_decorator.value.include?('{{resources}}')
    end
  end

  private

  def feature_service
    "Features::#{name.camelize}".safe_constantize.presence || Features::Feature
  end
end
