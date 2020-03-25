class CurrentProfilesController < ApplicationController
  before_action :set_profile

  def create
    CurrentProfile.where(current_profile_id: @profile.id).destroy_all
    CurrentProfile.create! ids.map{ |id| { profile_id: id, current_profile_id: @profile.id } }
    
    @current_profiles = CurrentProfile.where(current_profile_id: @profile.id)
  end

  def update
    @current_profile = CurrentProfile.find_by(current_profile_id: @profile.id)
    @current_profile.update! profile_id: params[:id]

    @current_profiles = CurrentProfile.where(current_profile_id: @profile.id)
  end

  def destroy
    CurrentProfile.find_by(profile_id: params[:id]).destroy
    
    @current_profiles = CurrentProfile.where(current_profile_id: @profile.id)
  end

private

  def ids
    params.keys.include?("profile_id") ? [params[:profile_id]] : params[:profile_ids]
  end

  def set_profile
    @profile = current_user.credential.basic_profile
  end
end
