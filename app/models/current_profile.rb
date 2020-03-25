class CurrentProfile < ApplicationRecord
  belongs_to :current_profile, class_name: 'Profile'
  belongs_to :profile
end
