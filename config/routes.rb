Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: "static_pages#home"

  resources :products
  resources :orders
  resources :categories

  post 'add_to_cart', to: 'products#add_to_cart'
  delete 'remove_from_cart', to: 'orders#remove_from_cart'
end
