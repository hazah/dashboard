module CurrentConcernAreasHelper
  def current_concern_areas_select
    select_tag :id,
      options_from_collection_for_select(concern_areas, :id, :name, current_concern_area.concern_area_id),
        class: "custom-select", id: :current_concern_areas,
        data: { 
          remote: true,
          url: current_concern_area_path,
          method: :put,
          target: "component.concernArea"
        }
  end

  def current_concern_area
    @current_concern_area
  end
end
