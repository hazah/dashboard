class BasicProfile < Profile
  belongs_to :human, foreign_key: :agent_id
  has_one :detail, class_name: 'BasicProfileDetail'

  delegate :name_model, :email_model, to: :detail

  accepts_nested_attributes_for :detail, :human

  default_scope do
    includes(detail: [ :name_model, :email_model])
  end
end
