class MessagesController < ApplicationController
  def create
    @message = Message.create message_params
  end

private

  def message_params
    params.require(:message).permit :raw_content
  end
end
