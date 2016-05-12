Rails.application.routes.draw do
  root "suggestions#index"

  resources :users do
    collection do
      get 'sign_in'
      get 'sign_out'
    end
  end
  get 'login', to: 'users#sign_in', as: 'login'
  get 'logout', to: 'users#sign_out', as: 'logout'

  resources :suggestions
  resources :spotify_items
  resources :restaurants
  resource :session, only: [:new, :destroy]

  # OAuth callbacks
  get '/auth/spotify/callback', to: 'sessions#create', provider: 'spotify'
end
