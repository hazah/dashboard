class Credential < ApplicationRecord
  belongs_to :agent

  accepts_nested_attributes_for :agent
end
