module ApplicationHelper
  def natural_guilds
    @natural_guilds
  end

  def temperaments
    @temperaments
  end
  
  def agents
    @agents
  end

  def messages
    @messages
  end

  def new_message
    @new_message
  end

  def locations
    @locations
  end

  def current_temperament
    @current_temperament
  end

  def current_natural_guild
    @current_natural_guild
  end

  def current_agents
    @current_agents
  end

  def current_location
    @current_location
  end

  def simple_format model
    model = model.to_s unless model.is_a? String
    super
  end
end
