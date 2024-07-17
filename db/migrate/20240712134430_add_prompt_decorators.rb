# frozen_string_literal: true

class AddPromptDecorators < ActiveRecord::Migration[7.1]
  def change
    create_enum :prompt_decorator_types, %w[
      pre_question
      post_question
      pre_request
      post_request
      context_wrapper
      edit_instructions
      format_instructions
      example
      role
      translation
      uncategorized
    ]

    create_table :prompt_decorators do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description
      t.string :value, null: false
      t.enum :decorator_type, enum_type: :prompt_decorator_types, null: false, index: true, default: 'uncategorized'

      t.timestamps
    end

    create_join_table :warehouses, :prompt_decorators do |t|
      t.index :warehouse_id
      t.index :prompt_decorator_id
      t.index %i[warehouse_id prompt_decorator_id], unique: true
    end
  end
end
