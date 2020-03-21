class ConversationChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_from "conversation"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
