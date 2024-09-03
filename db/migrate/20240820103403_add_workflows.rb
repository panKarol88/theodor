# frozen_string_literal: true

class AddWorkflows < ActiveRecord::Migration[7.1]
  def change
    create_table :workflows do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description
      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :workflows_features do |t|
      t.references :workflow, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true
      t.integer :priority, null: false, default: 0
      t.jsonb :properties, null: false, default: {}
      t.timestamps
    end
  end
end
