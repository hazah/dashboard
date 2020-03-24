class BasicProfile < Profile
  has_one :detail, class_name: 'BasicProfileDetail'

  delegate  :name,
            :name=,
            :name_model,
            :email,
            :email=,
            :email_model,
          to: :detail

  accepts_nested_attributes_for :detail
end
