class AddSessionIdsToConversationMessage < ActiveRecord::Migration[7.1]
  def change
    change_table :conversation_messages, bulk: true do |t|
      t.uuid :session_id, index: true
      t.uuid :trace_id, index: true
      t.uuid :generation_id, index: true
    end
  end
end
