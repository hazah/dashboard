class SessionChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_for current_user
    else
      stream_from "unauthenticated"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
