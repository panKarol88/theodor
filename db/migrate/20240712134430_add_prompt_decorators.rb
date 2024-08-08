# frozen_string_literal: true

class AddPromptDecorators < ActiveRecord::Migration[7.1]
  def change
    create_table :prompt_decorators do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description
      t.string :value, null: false
      t.references :feature, null: false, foreign_key: true
      t.integer :priority, null: false, default: 0

      t.timestamps
    end

    add_index :prompt_decorators, %i[priority feature_id], unique: true
  end
end
