class User < ApplicationRecord
  belongs_to :credential
  has_many :messages

  after_create_commit { SessionJob.perform_later self }
end
