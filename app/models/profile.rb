class Profile < ApplicationRecord
  has_many :credentials
  has_many :conversations
  has_many :network_modes
  has_and_belongs_to_many :parents, class_name: 'AggregateProfileDetail',
    foreign_key: :child_profile_id,
    association_foreign_key: :parent_profile_id,
    join_table: :child_profiles_parent_profiles
end
