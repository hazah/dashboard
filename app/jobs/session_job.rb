class SessionJob < ApplicationJob
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(*args)
    args.each do |user|
      if user.expires_at > Time.now
        SessionJob.set(wait: (user.expires_at - Time.now)).perform_later(user)
      else
        SessionPingJob.perform_later user
      end
    end
  end
end
