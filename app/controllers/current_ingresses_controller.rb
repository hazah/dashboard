class CurrentIngressesController < ApplicationController
  def update
    @current_ingress.attributes = { ingress_id: params[:id] }
    @current_ingress.save!
    head :no_content
  end
end
