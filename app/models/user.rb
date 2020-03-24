class User < ApplicationRecord
  belongs_to :credential

  after_create_commit { SessionJob.perform_later self }
end
