class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create message_params
    if @current_network_mode.network_mode == ConversationMode.first
      if @current_conversations.exists?
        @message.conversations = @current_conversations.map(&:conversation)
      else
        @message.conversations = @conversations
      end
    end
    set_messages
  end

private

  def message_params
    params.require(:message).permit :raw_content
  end
end
