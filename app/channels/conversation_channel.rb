class ConversationChannel < ApplicationCable::Channel
  def subscribed
    if params[:user_id]
      @current_user ||= begin
        user = User.find_by(id: params[:user_id], expires_at: Time.now..Float::INFINITY) 
        if user
          user.update expires_at: Rails.configuration.auth.session_timeout.minutes.from_now
        else
          reject
        end
        user
      end
      stream_for user.credential.basic_profile
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

private

  def current_user
    @current_user
  end
end
