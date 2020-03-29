Rails.application.routes.draw do
  root to: 'application#index'
  resources :conversations do
    collection do
      resource :end
    end
  end
  resources :messages
  
  resources :current_profiles
  resources :current_conversations
  resource :current_network_mode
  resource :current_category
  resource :current_category_child
  resource :current_context

  resource :registration
  resource :session
end
