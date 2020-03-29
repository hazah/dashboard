module MessagesHelper
  def messages_id
    :messages
  end

  alias :messages_class :messages_id

  def messages_options
    {
      id: messages_id,
      class: messages_class,
      data: {
        target: "component.messages",
        controller: "messages",
        action: "message:received->messages#received"
      }
    }
  end

  def messages
    @messages
  end

  def new_message
    @new_message
  end

  def send_button_color
    if current_network_mode.network_mode == ProfileMode.first
      current_profiles.exists? ? "btn-success" : "btn-secondary"
    elsif current_network_mode.network_mode == ConversationMode.first
      if current_conversations.exists?
        if current_conversations.map(&:conversation_id).select { |id| 
          conversations.where.not(ended_at: nil).pluck(:id).include?(id)
        }.any?
          "btn-warning"
        else
          "btn-primary"
        end
      else
        "btn-success"
      end
    end
  end

  def send_button_text
    if current_network_mode.network_mode == ProfileMode.first
      current_profiles.exists? ? "start" : "send"
    elsif current_network_mode.network_mode == ConversationMode.first
      "send"
    end
  end

  def send_button_disable_with
    if current_network_mode.network_mode == ProfileMode.first
      current_profiles.exists? ? "starting..." : "sending..."
    elsif current_network_mode.network_mode == ConversationMode.first
      "sending..."
    end
  end
  
  def message_form_controller
    if current_network_mode.network_mode == ProfileMode.first
      current_profiles.exists? ? :conversations : :messages
    elsif current_network_mode.network_mode == ConversationMode.first
      :messages
    end
  end
end
