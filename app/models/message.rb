class Message < ApplicationRecord
  after_create_commit do
    MessageReceivedJob.perform_later self
  end
  
  def to_s
    raw_content
  end
end
