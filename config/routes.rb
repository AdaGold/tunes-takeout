Rails.application.routes.draw do
  root "suggestions#index"

  resources :users do
    collection do
      get 'sign_in'
      get 'sign_out'
    end
  end

  resources :suggestions
  resources :spotify_items
  resources :restaurants
  resource :session, only: [:new, :destroy]
end
