class CurrentConversationsController < ApplicationController
  def create
    CurrentConversation.where(profile_id: @profile.id).destroy_all
    CurrentConversation.create! ids.map{ |id| { conversation_id: id, profile_id: @profile.id } }
    
    set_conversations
    set_current_conversations
    set_messages
  end

  def update
    @current_conversation = CurrentConversation.find_by(profile_id: @profile.id)
    @current_conversation.update! conversation_id: params[:id]

    set_conversations
    set_current_conversations
    set_messages
  end

  def destroy
    CurrentConversation.find_by(conversation_id: params[:id]).destroy
    
    set_conversations
    set_current_conversations
    set_messages
  end

private

  def ids
    params.keys.include?("conversation_id") ? [params[:conversation_id]] : params[:conversation_ids]
  end
end
