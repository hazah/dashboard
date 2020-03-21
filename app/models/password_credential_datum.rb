class PasswordCredentialDatum < ApplicationRecord
  belongs_to :password_credential
  belongs_to :email_address
  belongs_to :password_model, class_name: 'Password'
  
  delegate :email,        to: :email_address
  delegate :authenticate, to: :password_model

  accepts_nested_attributes_for :email_address
  accepts_nested_attributes_for :password_model
end
