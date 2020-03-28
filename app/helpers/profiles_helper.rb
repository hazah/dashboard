module ProfilesHelper
  def profiles
    @profiles
  end

  def basic_profile_class(profile)
    if current_profiles.map(&:profile_id).include?(profile.id)
      ' btn-secondary'
    end
  end

  def aggregate_profile_class(profile)
    basic_profile_class(profile)
  end

  def basic_profile_network_link_data(profile)
    {
      id: profile.id,
      action: "click->network-links#toggle",
      target: "network-links.networkLink"
    }
  end
end
