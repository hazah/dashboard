class CurrentProfilesController < ApplicationController
  def create
    CurrentProfile.where(current_profile_id: @profile.id).destroy_all
    CurrentProfile.create! ids.map{ |id| { profile_id: id, current_profile_id: @profile.id } }
    
    set_current_profiles
  end

  def update
    CurrentProfile.find_by(current_profile_id: @profile.id).update! profile_id: params[:id]

    set_current_profiles
  end

  def destroy
    CurrentProfile.find_by(current_profile_id: @profile.id, profile_id: params[:id]).destroy
    
    set_current_profiles
  end

private

  def ids
    params.keys.include?("profile_id") ? [params[:profile_id]] : params[:profile_ids]
  end
end
