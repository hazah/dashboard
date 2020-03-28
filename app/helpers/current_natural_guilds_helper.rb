module CurrentNaturalGuildsHelper
  def current_natural_guild
    @current_natural_guild
  end
  
  def current_natural_guilds_select
    select_tag :id,
      options_from_collection_for_select(natural_guilds, :id, :name, current_natural_guild.natural_guild_id),
        class: "custom-select", id: :current_natural_guild,
        data: { remote: true, url: current_natural_guild_path, method: :put }
  end
end
