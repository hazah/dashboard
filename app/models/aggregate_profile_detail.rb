class AggregateProfileDetail < ApplicationRecord
  belongs_to :aggregate_profile
  has_and_belongs_to_many :children, class_name: 'Profile',
    foreign_key: :parent_profile_id,
    association_foreign_key: :child_profile_id,
    join_table: :child_profiles_parent_profiles
end
