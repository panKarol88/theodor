class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  has_and_belongs_to_many :warehouses
end
