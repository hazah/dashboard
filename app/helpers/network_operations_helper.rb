module NetworkOperationsHelper
  def network_operations_id
    :network_operations
  end

  alias :network_operations_class :network_operations_id

  def network_operations_options
    {
      id: network_operations_id,
      class: network_operations_class
    }
  end
end