class ConversationsController < ApplicationController
  def create
    @children = @current_profiles.map(&:profile) << @profile
    @aggregate = AggregateProfile.create detail: AggregateProfileDetail.create(children: @children), agent: @profile.human
    @conversation = Conversation.create aggregate_profile: @aggregate
    @message = @conversation.messages.create message_params unless message_params[:raw_content].blank?

    @profiles = Profile.where.not(id: @profile.id)

    @current_conversation.attributes = { conversation_id: @conversation.id }
    @current_conversation.save!
  end

  def update
    @current_conversation.attributes = { conversation_id: @conversation.id }
    @current_conversation.save!
  end

  def destroy
    @current_conversation.destroy if @current_conversation.conversation_id == params[:id].to_i
  end

private

  def message_params
    params.require(:message).permit :raw_content
  end
end
