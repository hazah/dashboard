class ApplicationController < ActionController::Base
  before_action do
    @current_natural_guild = CurrentNaturalGuild.first || CurrentNaturalGuild.create(natural_guild: NaturalGuild.first)
    @current_ingress = CurrentIngress.first || CurrentIngress.create(ingress: Ingress.first)
    @current_location = CurrentLocation.first || CurrentLocation.new
    @current_agents = CurrentAgent.all
  end

  def index
    @natural_guilds = NaturalGuild.all
    @ingresses      = Ingress.all
    @agents         = Agent.includes(:email_address).all
    @messages       = Message.all
    @locations      = Location.all

    @new_message = Message.new
  end
end
