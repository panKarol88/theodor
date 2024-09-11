# frozen_string_literal: true

module Interface
  module ResourceableHelper
    extend ActiveSupport::Concern
    include Helpers::ValidationHelper

    included do
      validates :name, presence: true, uniqueness: true
      validates :description, presence: true
      validate :name_is_snakecase

      def self.restricted_by(user:)
        return all if user.blank?

        raise NotImplementedError
      end
    end
  end
end
