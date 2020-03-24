class CurrentConcernAreasController < ApplicationController
  def update
    @current_concern_area.attributes = { concern_area_id: params[:id] }
    @current_concern_area.save!
    head :no_content
  end
end
