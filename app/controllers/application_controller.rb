class ApplicationController < ActionController::Base
  before_action do
    @current_natural_guild = CurrentNaturalGuild.first || CurrentNaturalGuild.create(natural_guild: NaturalGuild.first)
    @current_temperament = CurrentTemperament.first || CurrentTemperament.create(temperament: Temperament.first)
    @current_location = CurrentLocation.first || CurrentLocation.new
    @current_agents = CurrentAgent.all
  end

  def index
    @natural_guilds = NaturalGuild.all
    @temperaments   = Temperament.all
    @agents         = Agent.includes(:email_address).all
    @messages       = Message.order(created_at: :desc).limit(30).all
    @locations      = Location.all

    @new_message = Message.new
  end
end
