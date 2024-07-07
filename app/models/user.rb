# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  has_and_belongs_to_many :warehouses
  has_many :data_crumbs, through: :warehouses
end
