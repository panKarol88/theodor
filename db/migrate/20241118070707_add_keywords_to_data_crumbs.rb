class AddKeywordsToDataCrumbs < ActiveRecord::Migration[7.1]
  def change
    add_column :data_crumbs, :keywords, :jsonb, default: [], null: false
  end
end
