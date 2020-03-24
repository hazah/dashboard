class CurrentNaturalGuildsController < ApplicationController
  def update
    @current_natural_guild.attributes = { natural_guild_id: params[:id] }
    @current_natural_guild.save
    
    @concern_areas  = @current_natural_guild.natural_guild.concern_areas
    
    @profile = current_user.credential.basic_profile
    @current_concern_area = CurrentConcernArea.find_by(profile_id: @profile.id, natural_guild: @current_natural_guild.natural_guild) || CurrentConcernArea.create(concern_area: @current_natural_guild.natural_guild.concern_areas.first, profile_id: @profile.id, natural_guild: @current_natural_guild.natural_guild)
  end
end
