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
    @current_profiles.exists? ? "btn-success" : "btn-secondary"
  end

  def send_button_text
    @current_profiles.exists? ? "start" : "send"
  end

  def send_button_disable_with
    @current_profiles.exists? ? "starting..." : "sending..."
  end
  
  def message_form_controller
    @current_profiles.exists? ? :conversations : :messages
  end
end
