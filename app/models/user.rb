class User < ApplicationRecord
  after_create_commit do
    SessionJob.perform_later self
  end

  belongs_to :credential
end
