class Agent < ApplicationRecord
  belongs_to :email_address
  
  def to_s
    name
  end
end
