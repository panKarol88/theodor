# frozen_string_literal: true

module Helpers
  module ValidationHelper
    private

    def name_is_snakecase
      errors.add(:name, 'is not a snakecase') unless name =~ /\A[a-z0-9_]+\z/
    end
  end
end
