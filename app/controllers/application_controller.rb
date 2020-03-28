class ApplicationController < ActionController::Base
  before_action :authenticate!

  before_action if: :current_user? do
    set_profile
    set_current_natural_guild
    set_current_concern_area
    set_current_location
    set_current_network_mode
    set_current_profiles
    set_current_conversations
    set_new_conversation
    set_new_message
    set_natural_guilds
    set_concern_areas
    set_profiles
    set_conversations
    set_locations
    set_network_modes
    set_messages
  end

private

  def set_profile
    @profile = current_user.credential.basic_profile
  end

  def set_current_natural_guild
    @current_natural_guild = CurrentNaturalGuild.find_or_initialize_by profile_id: @profile.id do |current_natural_guild|
      current_natural_guild.natural_guild ||= NaturalGuild.first
    end
  end

  def set_current_concern_area
    @current_concern_area = CurrentConcernArea.find_or_initialize_by profile_id: @profile.id, natural_guild: @current_natural_guild.natural_guild do |current_concern_area|
      current_concern_area.concern_area ||= @current_natural_guild.natural_guild.concern_areas.first
    end
  end

  def set_current_location
    @current_location = CurrentLocation.find_or_initialize_by profile_id: @profile.id
  end

  def set_current_network_mode
    @current_network_mode = CurrentNetworkMode.find_or_initialize_by profile_id: @profile.id do |current_network_mode|
      current_network_mode.network_mode ||= ProfileMode.first
    end
  end

  def set_current_profiles
    @current_profiles = CurrentProfile.where current_profile_id: @profile.id
  end

  def set_current_conversations
    @current_conversations = CurrentConversation.where profile_id: @profile.id
  end

  def set_new_conversation
    @new_conversation = Conversation.new
  end

  def set_new_message
    @new_message = Message.new
  end

  def set_natural_guilds
    @natural_guilds = NaturalGuild.all
  end

  def set_concern_areas
    @concern_areas = @current_natural_guild.natural_guild.concern_areas
  end

  def set_profiles
    @profiles = Profile.where.not(id: @profile.id).order(created_at: :desc)
  end
  
  def set_conversations
    @conversations = @profile.human.profiles.where(type: 'AggregateProfile').order(created_at: :desc).map(&:conversation)
  end

  def set_locations
    @locations = Location.all
  end

  def set_network_modes
    @network_modes = NetworkMode.all
  end

  def set_messages
    @messages = current_user.credential.messages
    if @current_network_mode.network_mode == ConversationMode.first
      @messages = @messages.joins(:conversations)
      if @current_conversations.exists?
        @messages = @messages.where(conversations: { id: @current_conversations.map(&:conversation_id) })
      else
        @messages = @messages.where(conversations: { id: @conversations.map(&:id) })
      end
    end
    @messages = @messages.distinct.order(created_at: :desc).limit(30).reverse
  end
  
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
