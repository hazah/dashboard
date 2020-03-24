module ApplicationHelper
  def natural_guilds
    @natural_guilds
  end

  def concern_areas
    @concern_areas
  end
  
  def profiles
    @profiles
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

  def current_concern_area
    @current_concern_area
  end

  def current_natural_guild
    @current_natural_guild
  end

  def current_profiles
    @current_profiles
  end

  def current_location
    @current_location
  end

  def simple_format model
    model = model.to_s unless model.is_a? String
    super
  end
end
