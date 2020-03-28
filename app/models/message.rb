class Message < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :conversations
  has_rich_text :raw_content
  after_create_commit { MessageReceivedJob.perform_later self }
end
