class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create message_params
    if @current_network_mode.network_mode == ConversationMode.first
      if @current_conversations.exists?
        @message.conversations = Conversation.where(ended_at: nil, current_conversations: @current_conversations)
      else
        @message.conversations = @conversations.where(ended_at: nil)
      end
    end
    set_messages
  end

private

  def message_params
    params.require(:message).permit :raw_content
  end
end
