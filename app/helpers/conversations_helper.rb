module ConversationsHelper
  def new_conversation
    @new_conversation
  end

  def conversations
    @conversations
  end

  def conversation_id
    :conversation
  end

  alias :conversation_class :conversation_id

  def conversation_options
    {
      id: conversation_id,
      class: conversation_class
    }
  end

  class ConversationLink
    include ActiveModel::Model

    attr_accessor :conversation

    def initialize(conversation)
      @conversation = conversation
    end

    def to_key
      conversation.to_key
    end
  end

  def conversation_links
    conversations.map { |conversation| ConversationLink.new conversation }
  end

  def conversation_classes(conversation)
    if current_conversations.map(&:conversation_id).include?(conversation.id)
      ' btn-primary'
    else
      ' btn-success'
    end
  end

  def conversation_link_data(conversation, index)
    {
      id: conversation.id,
      index: index,
      action: "click->conversation-links#toggle",
      target: "conversation-links.conversationLink"
    }
  end
end
