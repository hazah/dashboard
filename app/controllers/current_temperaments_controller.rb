class CurrentTemperamentsController < ApplicationController
  def update
    @current_temperament.attributes = { temperament_id: params[:id] }
    @current_temperament.save!
    head :no_content
  end
end
