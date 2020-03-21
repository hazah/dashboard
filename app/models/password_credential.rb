class PasswordCredential < Credential
  has_one :password_credential_datum

  
  delegate :email,        to: :password_credential_datum
  delegate :authenticate, to: :password_credential_datum

  accepts_nested_attributes_for :password_credential_datum
end