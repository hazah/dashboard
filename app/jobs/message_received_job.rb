class MessageReceivedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    args.each do |message|
      conversations = Conversation.joins(:current_conversations).where(current_conversations: { profile_id: message.user.credential.basic_profile })

      profiles = BasicProfile.all
      
      conversations.each do |conversation|
        profiles = profiles.where(id: conversations.first.aggregate_profile.detail.children.map(&:id))
      end

      profiles.distinct.each do |profile|
        ConversationChannel.broadcast_to profile, ApplicationController.render(message)
      end
    end
  end
end
