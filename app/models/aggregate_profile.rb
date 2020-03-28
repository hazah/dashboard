class AggregateProfile < Profile
  belongs_to :agent
  has_one :detail, class_name: 'AggregateProfileDetail'
  has_one :conversation
  default_scope do
    includes(:detail)
  end
end