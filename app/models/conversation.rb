class Conversation < ApplicationRecord
  has_and_belongs_to_many :messages
  belongs_to :aggregate_profile
  has_many :messages
end
