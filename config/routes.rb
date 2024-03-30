Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"
  resources :users
  resources :videos, only: [:new, :create]
end
