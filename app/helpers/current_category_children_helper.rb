module CurrentCategoryChildrenHelper
  def current_category_child
    @current_category_child
  end
  
  def current_category_children_select
    select_tag :id,
      options_from_collection_for_select(category_children, :id, :name, current_category_child.category_id),
        class: "custom-select", id: :current_category_children,
        data: { 
          remote: true,
          url: current_category_child_path,
          method: :put,
          target: "component.categoryChild"
        }
  end
end
