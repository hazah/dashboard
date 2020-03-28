class ApplicationController < ActionController::Base
  before_action :authenticate!

  before_action if: :current_user? do
    @profile = current_user.credential.basic_profile
    @current_natural_guild = CurrentNaturalGuild.find_or_initialize_by profile_id: @profile.id do |current_natural_guild|
      current_natural_guild.natural_guild ||= NaturalGuild.first
    end
    @current_concern_area = CurrentConcernArea.find_or_initialize_by profile_id: @profile.id, natural_guild: @current_natural_guild.natural_guild do |current_concern_area|
      current_concern_area.concern_area ||= @current_natural_guild.natural_guild.concern_areas.first
    end
    @current_location = CurrentLocation.find_or_initialize_by profile_id: @profile.id
    @current_profiles = CurrentProfile.where current_profile_id: @profile.id
    @current_conversation = CurrentConversation.find_or_initialize_by(profile_id: @profile.id) do |current_conversation|
      current_conversation.conversation ||= Conversation.new aggregate_profile: AggregateProfile.new(detail: AggregateProfileDetail.new)
    end
    @new_conversation = Conversation.new
    @new_message  = Message.new
  end

  def index
    @natural_guilds = NaturalGuild.all
    @concern_areas  = @current_natural_guild.natural_guild.concern_areas
    @profiles       = Profile.where.not(id: @profile.id).where(id: @current_conversation.conversation.aggregate_profile.detail.children)
    @locations      = Location.all
    
    @messages     = Message.where(conversation_id: @current_conversation.conversation_id).order(created_at: :desc).limit(30).all
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
