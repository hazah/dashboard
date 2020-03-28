module MainWindowHelper
  def main_window_id
    :main_window
  end

  alias :main_window_class :main_window_id

  def main_window_options
    {
      id: main_window_id,
      class: main_window_class
    }
  end
end