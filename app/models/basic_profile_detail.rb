class BasicProfileDetail < ApplicationRecord
  belongs_to :basic_profile, optional: true
  belongs_to :name_model, class_name: 'Name'
  belongs_to :email_model, class_name: 'Email'

  has_many :credentials, through: :basic_profile

  delegate  :name,
            :name=,
          to: :name_model
  delegate  :email,
            :email=,
          to: :email_model

  accepts_nested_attributes_for :basic_profile, :name_model, :email_model
end
