class CurrentCategoryChildrenController < ApplicationController
  def update
    @current_category_child.attributes = { category_id: params[:id] }
    @current_category_child.save!
    head :no_content
  end
end
