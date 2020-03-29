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

    attr_accessor :context

    def initialize(context)
      @context = context
    end
  end
  
  def context_buttons
    contexts.map { |context| ContextButton.new context }
  end

  def context_button_data(context)
    {
      target: "context.button",
      action: "click->context#toggle",
      id: context.id
    }
  end
end