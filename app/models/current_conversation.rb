class CurrentConversation < ApplicationRecord
  belongs_to :profile
  belongs_to :conversation
end
