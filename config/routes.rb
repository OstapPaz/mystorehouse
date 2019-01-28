Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  require 'resque/server'

  mount Resque::Server.new, at: '/resque'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'static_pages#home'

  resources :products, only: [:index, :show] do
    resources :comments
  end
  resources :orders, except: [:destroy]
  resources :feedbacks, except: [:index]

  get 'admin', to: 'admin/base#admin_home'
  get 'orders/change_status/:id', to: 'admin/orders#change_status', as: 'change_status'
  namespace :admin do
    resources :categories, except: [:new]
    resources :discounts, only: [:index, :create, :update, :show]
    resources :feedbacks, only: [:index]
    resources :products, except: [:index, :show]
    resources :orders, only: [:destroy]
  end

  get 'contact', to: 'static_pages#contact'
  get 'customer_contacts/show', to: 'customer_contacts#show'
  patch 'customer_contacts/update', to: 'customer_contacts#update'

  post 'add_to_cart', to: 'carts#add_to_cart'
  delete 'remove_from_cart', to: 'carts#remove_from_cart'

  mount ActionCable.server => '/cable'

  MyStorehouse::Application.routes.draw do
    resources :products, only: [:index]
    root to: 'products#index'
  end

end
