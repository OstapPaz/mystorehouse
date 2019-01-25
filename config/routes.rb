Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  require 'resque/server'

  mount Resque::Server.new, at: '/resque'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'static_pages#home'

  resources :products do
    resources :comments
  end
  resources :orders
  resources :feedbacks

  namespace :admin do
    resources :categories, except: [:new]
    resources :discounts, only: [:index, :create, :update, :show]
  end

  get 'admin', to: 'static_pages#admin_home'
  get 'contact', to: 'static_pages#contact'
  get 'customer_contacts/show', to: 'customer_contacts#show'
  patch 'customer_contacts/update', to: 'customer_contacts#update'
  get 'order/all', to: 'orders#index_all'
  get 'orders/change_status/:id', to: 'orders#change_status', as: 'change_status'
  post 'create_comment', to: 'comments#create'
  post 'add_to_cart', to: 'carts#add_to_cart'
  delete 'remove_from_cart', to: 'carts#remove_from_cart'

  mount ActionCable.server => '/cable'

  MyStorehouse::Application.routes.draw do
    resources :products, only: [:index]
    root to: 'products#index'
  end

end
