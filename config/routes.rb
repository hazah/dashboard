Rails.application.routes.draw do
  root to: 'application#index'
  resources :messages
  
  resources :current_agents
  resource :current_natural_guild
  resource :current_temperament
  resource :current_location

  resource :registration
  resource :session
end
