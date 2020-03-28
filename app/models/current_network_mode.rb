class CurrentNetworkMode < ApplicationRecord
  belongs_to :network_mode
  belongs_to :profile
end
