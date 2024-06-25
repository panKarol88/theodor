# frozen_string_literal: true

class AddUserWarehouseDataCrumbRefs < ActiveRecord::Migration[7.1]
  def change
    add_reference :data_crumbs, :warehouse, null: true, foreign_key: true

    create_join_table :users, :warehouses do |t|
      t.index :user_id
      t.index :warehouse_id
    end
  end
end
