class CurrentCategoriesController < ApplicationController
  def update
    @current_category.attributes = { category_id: params[:id]  }
    @current_category.save
    
    set_current_category
    set_current_category_child
    set_categories
    set_category_children
  end
end
