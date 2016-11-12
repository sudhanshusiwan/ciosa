Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'products#index'

  resources :products
  resources :organizations

  resources :cart_products, :only => [:index, :create, :update, :destroy]
  resources :orders, :only => [:index, :create, :show, :destroy]
end
