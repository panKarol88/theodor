# frozen_string_literal: true

class DataCrumb < ApplicationRecord
  validates :content, presence: true

  belongs_to :warehouse, inverse_of: :data_crumbs
  has_many :users, through: :warehouse

  # alternative:
  # after_create_commit -> do
  #   broadcast_prepend_to "data_crumbs",
  #                       partial: "data_crumbs/data_crumb",
  #                       locals: { data_crumb: self },
  #                       target: "data_crumbs"
  # end

  # after_create_commit -> { broadcast_prepend_later_to "data_crumbs" }
  # after_update_commit -> { broadcast_replace_later_to "data_crumbs" }
  # after_destroy_commit -> { broadcast_remove_to "data_crumbs" }

  broadcasts_to ->(data_crumb) { [data_crumb.warehouse, 'data_crumbs'] }, inserts_by: :prepend
end
