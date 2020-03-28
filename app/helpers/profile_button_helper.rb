module ProfileButtonHelper
  def profile_button_id
    :profile_button
  end

  alias :profile_button_class :profile_button_id

  def profile_button_options
    {
      id: profile_button_id,
      class: profile_button_class,
      data: {
        controller: "current-profile"
      }
    }
  end
end