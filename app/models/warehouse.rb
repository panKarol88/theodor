class Warehouse < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :name_is_snakecase

  private

  def name_is_snakecase
    errors.add(:name, 'is not a snakecase') unless name =~ /\A[a-z_]+\z/
  end
end
