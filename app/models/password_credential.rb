class PasswordCredential < Credential
  attribute :name,                  :string
  attribute :email,                 :string
  attribute :password,              :string
  attribute :password_confirmation, :string

  belongs_to :basic_profile, foreign_key: "profile_id"
  has_one :datum, class_name: 'PasswordCredentialDatum'

  accepts_nested_attributes_for :basic_profile, :datum
  
  delegate :authenticate, to: :datum
end