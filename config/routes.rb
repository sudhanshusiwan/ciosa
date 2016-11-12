Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'products#index'

  resources :products do
    collection do
      get :search
    end
  end

  resources :organizations

  resources :cart_products, :only => [:index, :create, :update, :destroy]
  resources :orders, :only => [:index, :create, :show, :destroy]
end
