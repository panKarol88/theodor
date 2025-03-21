# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @warehouses = current_user.warehouses
    @conversation_logs = ConversationMessage.all
  end
end
