class Human < Agent
  has_one :detail, class_name: "HumanDetail"
end