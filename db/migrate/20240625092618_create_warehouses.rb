# frozen_string_literal: true

class CreateWarehouses < ActiveRecord::Migration[7.1]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
