class Conversation < ApplicationRecord
  belongs_to :aggregate_profile
  has_many :messages
end
