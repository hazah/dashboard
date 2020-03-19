class CurrentLocationsController < ApplicationController
  def create
    @current_location.attributes = { location_id: params[:location_id] }
    @current_location.save!
  end

  def update
    @current_location.attributes = { location_id: params[:id] }
    @current_location.save!
  end

  def destroy
    @current_location.destroy if @current_location.location_id == params[:id].to_i
  end
end
