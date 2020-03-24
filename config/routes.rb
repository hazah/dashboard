Rails.application.routes.draw do
  root to: 'application#index'
  resources :messages
  
  resources :current_basic_profiles
  resource :current_natural_guild
  resource :current_concern_area
  resource :current_location

  resource :registration
  resource :session
end
