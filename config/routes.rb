Rails.application.routes.draw do
  root to: 'application#index'
  resources :conversations
  resources :messages
  
  resources :current_profiles
  resources :current_conversations
  resource :current_network_mode
  resource :current_natural_guild
  resource :current_concern_area
  resource :current_location

  resource :registration
  resource :session
end
