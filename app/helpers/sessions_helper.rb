module SessionsHelper
  def credential
    @credential
  end

  def session_id
    :session
  end

  alias :session_class :session_id

  def session_options
    {
      id: session_id,
      class: session_class
    }
  end
end
