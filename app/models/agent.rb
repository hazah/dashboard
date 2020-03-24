class Agent < ApplicationRecord
  has_many :profiles
  has_many :credentials, through: :profiles
end
