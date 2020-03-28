class CurrentConversationsController < ApplicationController
  before_action :set_profiles0

  def create
    CurrentConversation.where(conversation_id: @profile.id).destroy_all
    CurrentConversation.create! ids.map{ |id| { conversation_id: id, profile_id: @profile.id } }
    
    @current_conversations = CurrentConversation.where(profile_id: @profile.id)
  end

  def update
    @current_profile = CurrentConversation.find_by(profile_id: @profile.id)
    @current_profile.update! conversation_id: params[:id]

    @current_conversations = CurrentConversation.where(profile_id: @profile.id)
  end

  def destroy
    CurrentConversation.find_by(conversation_id: params[:id]).destroy
    
    @current_conversations = CurrentConversation.where(profile_id: @profile.id)
  end

private

  def ids
    params.keys.include?("conversation_id") ? [params[:conversation_id]] : params[:conversation_ids]
  end

  def set_profiles
    @profiles = Profile.where.not(id: @profile.id)
  end
end
