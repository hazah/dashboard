class EndsController < ApplicationController
  def create
    Conversation.where(ended_at: nil, current_conversations: @current_conversations).update_all ended_at: Time.now
    CurrentConversation.destroy_all
    set_conversations
    set_current_conversations
    set_messages
  end
end
