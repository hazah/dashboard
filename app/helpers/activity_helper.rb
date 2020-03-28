module ActivityHelper
  def activity_id
    :activity
  end

  alias :activity_class :activity_id

  def activity_options
    {
      id: activity_id,
      class: activity_class
    }
  end
end