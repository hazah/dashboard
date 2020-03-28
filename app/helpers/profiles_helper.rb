module ProfilesHelper
  def profiles
    @profiles
  end

  def basic_profile_classes(profile)
    if current_profiles.map(&:profile_id).include?(profile.id)
      ' btn-secondary'
    end
  end

  def aggregate_profile_classes(profile)
    basic_profile_classes(profile)
  end

  def basic_profile_network_link_data(profile, index)
    {
      id: profile.id,
      index: index,
      action: "click->network-links#toggle",
      target: "network-links.networkLink"
    }
  end

  def aggregate_profile_network_link_data(profile, index)
    basic_profile_network_link_data profile, index
  end
end
