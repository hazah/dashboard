class Message < ApplicationRecord
  after_create_commit { MessageReceivedJob.perform_later self }
end
