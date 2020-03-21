class SessionStartedJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(*args)
    args.each do |user|
      if user.expires_at > Time.now
        SessionStartedJob.set(wait: (user.expires_at - Time.now)).perform_later(user)
      else
        logger.info "Session expired for User #{user.id}"
        SessionChannel.broadcast_to user, { session: false, url: new_session_path }
      end
    end
  end
end
