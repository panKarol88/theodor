# frozen_string_literal: true

class CreateConversationMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_messages do |t|
      t.text :user_message, null: false
      t.text :bot_message, null: false

      t.timestamps
    end
  end
end
