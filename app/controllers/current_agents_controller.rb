class CurrentAgentsController < ApplicationController
  def create
    CurrentAgent.destroy_all
    CurrentAgent.create! ids.map{ |id| { agent_id: id } }
    
    @current_agents = CurrentAgent.all
  end

  def update
    @current_agent = CurrentAgent.first
    @current_agent.update! agent_id: params[:id]

    @current_agents = CurrentAgent.all
  end

  def destroy
    CurrentAgent.find_by(agent_id: params[:id]).destroy
    
    @current_agents = CurrentAgent.all
  end

private

  def ids
    params.keys.include?("agent_id") ? [params[:agent_id]] : params[:agent_ids]
  end
end
