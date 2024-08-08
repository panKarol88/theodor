# frozen_string_literal: true

class AddFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description
      t.timestamps
    end

    create_join_table :features, :warehouses do |t|
      t.index :feature_id
      t.index :warehouse_id
    end
  end
end
