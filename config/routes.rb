Rails.application.routes.draw do
  root "suggestions#index"

  resources :users
  resources :suggestions
  resources :spotify_items
  resources :restaurants
  resources :sessions
end
