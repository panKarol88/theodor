# frozen_string_literal: true

class User < ApplicationRecord
  # TODO: implement jwt_revocation_strategy
  devise :database_authenticatable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_and_belongs_to_many :warehouses
  has_many :data_crumbs, through: :warehouses
end
