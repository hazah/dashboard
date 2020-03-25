module ApplicationHelper
  def natural_guilds
    @natural_guilds
  end

  def concern_areas
    @concern_areas
  end
  
  def profiles
    @profiles
  end

  def messages
    @messages
  end

  def new_message
    @new_message
  end

  def locations
    @locations
  end

  def current_concern_area
    @current_concern_area
  end

  def current_natural_guild
    @current_natural_guild
  end

  def current_profiles
    @current_profiles
  end

  def current_location
    @current_location
  end

  def natural_guilds_select
    select_tag :id,
      options_from_collection_for_select(natural_guilds, :id, :name, current_natural_guild&.natural_guild_id),
        class: "custom-select", id: :current_natural_guild,
        data: { remote: true, url: current_natural_guild_path, method: :put }
  end

  def concern_areas_select
    select_tag :id,
        options_from_collection_for_select(concern_areas, :id, :name, current_concern_area&.concern_area_id),
          class: "custom-select", id: :current_concern_areas,
          data: { 
            remote: true,
            url: current_concern_area_path,
            method: :put,
            controller: "concern-area",
            action: "natural_guild:changed->concern-area#update"
          }
  end

  def context_navigation
    concat natural_guilds_select
    concern_areas_select
  end

  def profile_button
    content_tag :div, data: { controller: "current-profile" } do
      concat button_tag "profile", class: "btn btn-secondary", data: { action: "click->current-profile#menu" }
      concat content_tag :ul, content_tag(:li, link_to('Log out', :session, method: :delete, remote: true)), data: { target: "current-profile.menu" }
    end
  end

  def location_list
    content_tag :div, data: { controller: "locations" } do
      render locations
    end
  end

  def message_list
    content_tag :div, id: "messages", class: "messages", data: { controller: "messages", action: "message:received->messages#received" } do
      render messages
    end
  end

  def message_text_area(form)
    content_tag :div, class: "input-group" do
      concat form.rich_text_area(:raw_content,  
        class: "form-control",
        data: {
          target: "message.message",
          action: "keypress->message#keypress"
        }
      )
      concat send_message_button form
    end
  end

  def send_message_button(form)
    content_tag :div, class: "input-group-append" do
      form.button :send, 
        class: "input-group-text btn btn-secondary",
        data: {
          target: "message.send",
          action: "click->message#send",
          disable_with: "sending..."
        }
    end
  end

  def message_form
    form_with model: new_message, data: { controller: :message } do |form|
      concat message_text_area form
    end
  end

  def profile_list
    content_tag :div, data: { controller: "profile", action: "message:received->messages#received", profile_last: nil } do
      concat content_tag :div
      concat content_tag(:div) {
        render profiles
      }
    end
  end
end
