class CurrentNetworkModesController < ApplicationController

  def update
    @initial_mode_profile = @current_network_mode.network_mode == ProfileMode.first
    @current_network_mode.attributes = { network_mode_id: params[:id] }
    @current_network_mode.save!
    set_messages
  end

private

  def ids
    params.keys.include?("conversation_id") ? [params[:conversation_id]] : params[:conversation_ids]
  end
end
