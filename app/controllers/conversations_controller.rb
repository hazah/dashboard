class ConversationsController < ApplicationController
  def create
    @children = @current_profiles.map(&:profile) << @profile
    @aggregate = AggregateProfile.create detail: AggregateProfileDetail.create(children: @children), agent: @profile.human
    @conversation = Conversation.create aggregate_profile: @aggregate

    CurrentConversation.where(profile_id: @profile.id).destroy_all
    CurrentConversation.create! conversation_id: @conversation.id, profile_id: @profile.id
    
    set_current_conversations

    unless message_params[:raw_content].blank?
      @message = current_user.messages.create message_params
      @message.conversations = @current_conversations.map(&:conversation)
    end

    @current_network_mode.update network_mode: ConversationMode.first

    set_conversations
    set_messages
  end

private

  def message_params
    params.require(:message).permit :raw_content
  end
end
