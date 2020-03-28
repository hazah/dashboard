class Message < ApplicationRecord
  belongs_to :conversation
  has_rich_text :raw_content
  after_create_commit { MessageReceivedJob.perform_later self }
end
