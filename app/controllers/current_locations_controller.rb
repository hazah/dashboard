class CurrentLocationsController < ApplicationController
  before_action :set_locations

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
    @current_location = CurrentLocation.find_or_initialize_by profile_id: @profile.id
  end

private

  def set_locations
    @locations = Location.all
  end
end
