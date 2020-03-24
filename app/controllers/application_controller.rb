class ApplicationController < ActionController::Base
  before_action :authenticate!

  before_action if: :current_user? do
    @profile = current_user.credential.basic_profile
    @current_natural_guild = CurrentNaturalGuild.find_by(profile_id: @profile.id) || CurrentNaturalGuild.create(natural_guild: NaturalGuild.first, profile_id: @profile.id)
    @current_concern_area = CurrentConcernArea.find_by(profile_id: @profile.id) || CurrentConcernArea.create(concern_area: ConcernArea.first, profile_id: @profile.id)
    @current_location = CurrentLocation.find_by(profile_id: @profile.id) || CurrentLocation.new(profile_id: @profile.id)
    @current_profiles = CurrentBasicProfile.where(profile_id: @profile.id)
  end

  def index
    @natural_guilds = NaturalGuild.all
    @concern_areas  = @current_natural_guild.natural_guild.concern_areas
    @profiles       = BasicProfile.includes(detail: [:name_model, :email_model]).all
    @locations      = Location.all
    
    @messages       = Message.order(created_at: :desc).limit(30).all
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
