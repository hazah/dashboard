class CurrentBasicProfilesController < ApplicationController
  before_action :set_profile

  def create
    CurrentBasicProfile.where(profile_id: @profile.id).destroy_all
    CurrentBasicProfile.create! ids.map{ |id| { basic_profile_id: id, profile_id: @profile.id } }
    
    @current_agents = CurrentBasicProfile.where(profile_id: @profile.id)
  end

  def update
    @current_agent = CurrentBasicProfile.find_by(profile_id: @profile.id)
    @current_agent.update! basic_profile_id: params[:id]

    @current_agents = CurrentBasicProfile.where(profile_id: @profile.id)
  end

  def destroy
    CurrentBasicProfile.find_by(basic_profile_id: params[:id]).destroy
    
    @current_agents = CurrentBasicProfile.where(profile_id: @profile.id)
  end

private

  def ids
    params.keys.include?("basic_profile_id") ? [params[:basic_profile_id]] : params[:basic_profile_ids]
  end

  def set_profile
    @profile = current_user.credential.basic_profile
  end
end
