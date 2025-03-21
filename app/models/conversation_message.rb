class ConversationMessage < ApplicationRecord
  validates :user_message, :bot_message, presence: true
end
