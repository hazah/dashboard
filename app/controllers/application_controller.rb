class ApplicationController < ActionController::Base
  before_action :authenticate!

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

private
  
  def current_user
    if session[:current_user_id]
      @current_user ||= begin
        user = User.find_by(id: session[:current_user_id], expires_at: Time.now..Float::INFINITY) 
        if user
          user.update expires_at: auth.session_timeout.minutes.from_now
        else
          session.delete :current_user_id
          cookies.delete :user_id
        end
        user
      end
    end
  end

  def current_user?
    current_user.present?
  end

  def authenticate!
    redirect_to [:new, :session] if needs_new_session?
  end

  def needs_new_session?
    controller_needs_authentication? && no_current_user_session?
  end

  def controller_needs_authentication?
    ["sessions", "registrations"].include?(controller_name) == false
  end

  def no_current_user_session?
    current_user? == false
  end

  def auth
    Rails.configuration.auth
  end
end
