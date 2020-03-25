class PasswordCredentialDatum < ApplicationRecord
  belongs_to :password_credential
  belongs_to :password_model, class_name: 'Password'
  
  accepts_nested_attributes_for :password_model

  delegate :authenticate, to: :password_model
end
