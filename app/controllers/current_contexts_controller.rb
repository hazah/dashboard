class CurrentContextsController < ApplicationController
  def create
    @current_context.attributes = { context_id: params[:context_id] }
    @current_context.save!
  end

  def update
    @current_context.attributes = { context_id: params[:id] }
    @current_context.save!
  end

  def destroy
    @current_context.destroy if @current_context.context_id == params[:id].to_i
    @current_context = CurrentContext.find_or_initialize_by profile_id: @profile.id
  end
end
