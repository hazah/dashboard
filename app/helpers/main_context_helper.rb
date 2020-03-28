module MainContextHelper
  def main_context_id
    :main_context
  end

  alias :main_context_class :main_context_id

  def main_context_options
    {
      id: main_context_id,
      class: main_context_class
    }
  end
end