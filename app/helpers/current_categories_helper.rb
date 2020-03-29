module CurrentCategoriesHelper
  def current_category
    @current_category
  end
  
  def current_categories_select
    select_tag :id,
      options_from_collection_for_select(categories, :id, :name, current_category.category_id),
        class: "custom-select", id: :current_category,
        data: { remote: true, url: current_category_path, method: :put }
  end
end
