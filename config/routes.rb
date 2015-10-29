Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "home#index"
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  post 'home/add_to_cart'       => 'home#add_to_cart'
  post 'order_items/empty'      => 'order_items#empty'
  post 'orders/promocode'       => "orders#promocode"
  resources :authors
  resources :books
  resources :categories
  resources :credit_cards
  resources :orders
  resources :order_checkout
  resources :order_items
  resources :ratings
  resources :wish_lists
  match '*path', via: [:get, :post, :put, :delete], to: 'application#render_404'
end
