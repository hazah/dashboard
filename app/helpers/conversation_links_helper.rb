module ConversationLinksHelper
  def conversation_links_id
    :conversation_links
  end

  alias :conversation_links_class :conversation_links_id

  def conversation_links_options
    {
      id: conversation_links_id,
      class: conversation_links_class,
      data: {
        target: 'component.conversationLinks',
        controller: 'conversation-links',
        'conversation-links-last': ""
      }
    }
  end
end
