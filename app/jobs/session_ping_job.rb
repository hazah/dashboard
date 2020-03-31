class SessionPingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    args.each do |user|
      if user.expires_at > Time.now
        ActionCable.server.broadcast "unauthenticated", { session: user }
      else
        logger.info "Session expired for User #{user.id}"
        SessionChannel.broadcast_to user, { session: false }
        ActionCable.server.broadcast "unauthenticated", { session: false }
      end
    end
  end
end
