Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "home#index"
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post 'home/add_to_cart' => 'home#add_to_cart'
  post 'order_items/empty' => 'order_items#empty'
  resources :books
  resources :authors
  resources :categories
  resources :orders
  resources :ratings
  resources :order_checkout
  resources :order_items
  
end
