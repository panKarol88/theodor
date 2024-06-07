class DataCrumb < ApplicationRecord
  validates :content, presence: true
  after_create_commit -> { broadcast_prepend_to "data_crumbs" }
  after_update_commit -> { broadcast_replace_to "data_crumbs" }
  after_destroy_commit -> { broadcast_remove_to "data_crumbs" }

  # equivalent to:
  # after_create_commit -> do
  #   broadcast_prepend_to"data_crumbs",
  #                       partial: "data_crumbs/data_crumb",
  #                       locals: { data_crumb: self },
  #                       target: "data_crumbs"
  # end
end
