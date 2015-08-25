Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "home#index"
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books
  resources :authors
  resources :categories
  resources :orders
  resources :order_checkout
end
