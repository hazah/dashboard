class MessageReceivedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ActionCable.server.broadcast "conversation", args.map { |arg| ApplicationController.render arg }.join
  end
end
