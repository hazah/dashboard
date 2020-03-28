module NetworkLinksHelper
  def network_links_id
    :network_links
  end

  alias :network_links_class :network_links_id

  def network_links_options
    {
      id: network_links_id,
      class: network_links_class,
      data: {
        target: 'component.networkLinks',
        controller: 'network-links',
        'network-links-last': ""
      }
    }
  end
end
