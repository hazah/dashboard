class PasswordCredentialDatum < ApplicationRecord
  belongs_to :password_credential
  belongs_to :password_model, class_name: 'Password'

  delegate :basic_profile, to: :password_credential
  
  delegate  :email,
            :email=,
            :name,
            :name=,
          to: :profile
  
  delegate  :password=,
            :password_confirmation=,
            :password_digest,
            :authenticate,
          to: :password_model
  
  accepts_nested_attributes_for :password_model
end
