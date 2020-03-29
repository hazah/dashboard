class CurrentCategoryChild < ApplicationRecord
  belongs_to :parent, class_name: 'Category'
  belongs_to :category
  belongs_to :profile
end
