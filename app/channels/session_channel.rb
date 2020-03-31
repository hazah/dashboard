class SessionChannel < ApplicationCable::Channel
  def subscribed
    if params[:user_id]
      user = User.find_by(id: params[:user_id], expires_at: Time.now..Float::INFINITY) 
      if user
        user.update expires_at: Rails.configuration.auth.session_timeout.minutes.from_now
      else
        reject
      end
      stream_for user
    else
      stream_from "unauthenticated"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
  def receive(data)
    unless data["session"]
      ActionCable.server.remote_connections.where(visit: visit).disconnect
    end
  end
end
