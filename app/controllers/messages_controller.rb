class MessagesController < ApplicationController
  def create
    @message = @current_conversation.conversation.messages.create message_params
  end

private

  def message_params
    params.require(:message).permit :raw_content
  end
end
