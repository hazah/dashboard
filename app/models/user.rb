class User < ApplicationRecord
  after_create_commit do
    SessionStartedJob.set(wait: (expires_at - Time.now)).perform_later self
  end

  belongs_to :credential
end
