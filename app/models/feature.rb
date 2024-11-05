# frozen_string_literal: true

class Feature < ApplicationRecord
  include Interface::ResourceableHelper

  has_many :prompt_decorators, dependent: :destroy
  has_many :workflows_features, dependent: :destroy
  has_many :workflows, through: :workflows_features
  has_and_belongs_to_many :warehouses

  scope :priority_ordered, -> { order(:priority) }

  # TODO: move this method to some other abstraction
  def process(thread_object:, user:, feature_properties: {})
    feature_service.new(feature_record: self, thread_object:, user:, feature_properties:).process
  end

  def self.restricted_by(user:)
    left_outer_joins(:warehouses).where(warehouses: { id: [user.warehouses.ids, nil].flatten })
  end

  private

  def feature_service
    "Features::#{name.camelize}".safe_constantize.presence || Features::Feature
  end
end
