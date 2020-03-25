class Human < Agent
  has_one :detail, class_name: "HumanDetail"

  accepts_nested_attributes_for :detail
end