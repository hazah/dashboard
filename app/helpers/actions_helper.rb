module ActionsHelper
  def actions_id
    :actions
  end

  alias :actions_class :actions_id

  def actions_options
    {
      id: actions_id,
      class: actions_class,
      data: {
        target: "component.actions"#,
        # controller: "actions",
        # action: "message:received->actions#received"
      }
    }
  end
end