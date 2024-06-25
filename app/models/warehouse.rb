class Warehouse < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase

  has_many :data_crumbs, dependent: :destroy
  has_and_belongs_to_many :users

  private

  def name_is_snakecase
    errors.add(:name, 'is not a snakecase') unless name =~ /\A[a-z_]+\z/
  end
end
