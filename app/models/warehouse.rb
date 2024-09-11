# frozen_string_literal: true

class Warehouse < ApplicationRecord
  include Interface::ResourceableHelper

  has_many :data_crumbs, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :features

  def self.restricted_by(user:)
    joins(:users).where(users: { id: user.id })
  end
end
