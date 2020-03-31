class ApplicationController < ActionController::Base
  before_action { cookies.encrypted[:visit] ||= Digest::SHA1.hexdigest([Time.now, rand].join) }
  before_action :authenticate!

  before_action if: :current_user? do
    set_profile
    set_current_category
    set_current_category_child
    set_current_context
    set_current_network_mode
    set_current_profiles
    set_current_conversations
    set_new_conversation
    set_new_message
    set_categories
    set_category_children
    set_profiles
    set_conversations
    set_contexts
    set_network_modes
    set_messages
  end

private

  def set_profile
    @profile = current_user.credential.basic_profile
  end

  def set_current_category
    @current_category = CurrentCategory.find_or_initialize_by profile_id: @profile.id do |current_category|
      current_category.category ||= Category.where(parent: nil).first
    end
  end

  def set_current_category_child
    @current_category_child = CurrentCategoryChild.find_or_initialize_by profile_id: @profile.id, parent_id: @current_category.category_id do |current_category_child|
      current_category_child.category ||= @current_category.category.children.first
    end
  end

  def set_current_context
    @current_context = CurrentContext.find_or_initialize_by profile_id: @profile.id
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

  def set_categories
    @categories = Category.where(parent_id: nil).all
  end

  def set_category_children
    @category_children = @current_category.category.children
  end

  def set_profiles
    @profiles = Profile.order(created_at: :desc)
  end
  
  def set_conversations
    @conversations = Conversation.joins(aggregate_profile: { detail: :children }).where(aggregate_profile: { detail: { child_profiles_parent_profiles: { child_profile_id: @profile.id }}}).order(ended_at: :desc, created_at: :desc) 
  end

  def set_contexts
    @contexts = Context.all
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
    @messages = @messages.distinct.includes(:rich_text_raw_content).order(created_at: :desc).limit(30).reverse
  end
  
  def current_user
    if session[:current_user_id]
      @current_user ||= begin
        user = User.find_by(id: session[:current_user_id], expires_at: Time.now..Float::INFINITY) 
        if user
          user.update expires_at: auth.session_timeout.minutes.from_now
        else
          session.delete :current_user_id
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
