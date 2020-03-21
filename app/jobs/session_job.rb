class SessionJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(*args)
    args.each do |user|
      if user.expires_at > Time.now
        SessionJob.set(wait: (user.expires_at - Time.now)).perform_later(user)
        if user.updated_at == user.created_at
          ActionCable.server.broadcast "unauthenticated", { session: true }
        end
      else
        logger.info "Session expired for User #{user.id}"
        SessionChannel.broadcast_to user, { session: false, url: new_session_path }
      end
    end
  end
end
