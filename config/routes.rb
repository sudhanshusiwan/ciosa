Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'products#home'

  resources :products do
    collection do
      get :search, :manage_my_products, :home
    end
  end

  resources :organizations
  resources :ordered_products, only: [:index]

  resources :cart_products, :only => [:index, :create, :destroy] do
    post :update_quantity, on: :collection
  end

  resources :orders, :only => [:index, :create, :show] do
      post :cancel, on: :member
      get :check_out, on: :collection
  end
end
