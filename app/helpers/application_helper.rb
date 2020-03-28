module ApplicationHelper
  def application_id
    :dashboard
  end

  alias :application_class :application_id

  def application_options
    {
      id: application_id,
      class: application_class,
      data: {
        controller: :component,
        action: "component:refresh->component#refresh"
      }
    }
  end
end
