module ContextHelper
  def context_id
    :context
  end

  alias :context_class :context_id

  def context_options
    {
      id: context_id,
      class: context_class,
      data: {
        target: "component.context",
        controller: "context"
      } 
    }
  end

  class ContextButton
    include ActiveModel::Model

    attr_accessor :location

    def initialize(location)
      @location = location
    end
  end
  
  def context_buttons
    locations.map { |location| ContextButton.new location }
  end

  def context_button_data(location)
    {
      target: "context.button",
      action: "click->context#toggle",
      id: location.id
    }
  end
end