module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
  private
    
    def find_verified_user
      if user = User.find_by(id: cookies.encrypted[:user_id], expires_at: Time.now..Float::INFINITY)
        user.update expires_at: auth.session_timeout.minutes.from_now
        user
      end
    end

    def auth
      Rails.configuration.auth
    end
  end
end
