class CurrentNaturalGuildsController < ApplicationController
  def update
    @current_natural_guild.attributes = { natural_guild_id: params[:id] }
    @current_natural_guild.save
    @concern_areas  = @current_natural_guild.natural_guild.concern_areas
  end
end
