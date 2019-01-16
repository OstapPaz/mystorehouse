Rails.application.routes.draw do
  require 'resque/server'
  # Of course, you need to substitute your application name here, a block
  # like this probably already exists.
  MyStorehouse::Application.routes.draw do
    mount Resque::Server.new, at: '/resque'
  end

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'static_pages#home'

  resources :products
  resources :orders
  resources :categories
  resources :feedbacks
  resources :discounts, only: [:index, :create, :update, :show]

  get 'admin', to: 'static_pages#admin_home'
  get 'customer_contacts/show', to: 'customer_contacts#show'
  patch 'customer_contacts/update', to: 'customer_contacts#update'
  get 'order/all', to: 'orders#index_all'
  get 'orders/change_status/:id', to: 'orders#change_status', as: 'change_status'
  post 'create_comment', to: 'comments#create'
  post 'add_to_cart', to: 'products#add_to_cart'
  post 'update_cart', to: 'orders#update_cart'
  delete 'remove_from_cart', to: 'orders#remove_from_cart'
end
