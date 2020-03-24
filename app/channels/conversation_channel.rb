class ConversationChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_from "conversation"
    else
      stream_from "nothing"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
