class Profile < ApplicationRecord
  belongs_to :agent
  has_many :credentials

  accepts_nested_attributes_for :agent
end
