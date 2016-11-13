Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: 'users/registrations' }
  ActiveAdmin.routes(self)

  root 'products#index'

  resources :products do
    collection do
      get :search, :manage_my_products
    end
  end

  resources :organizations

  resources :cart_products, :only => [:index, :create, :destroy] do
    post :update_quantity, on: :collection
  end

  resources :orders, :only => [:index, :create, :show] do
      post :cancel, on: :member
      get :check_out, on: :collection
  end
end
