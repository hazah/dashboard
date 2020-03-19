class CurrentNaturalGuildsController < ApplicationController
  def update
    @current_natural_guild.attributes = { natural_guild_id: params[:id] }
    @current_natural_guild.save!
    head :no_content
  end
end
