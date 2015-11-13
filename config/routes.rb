Rails.application.routes.draw do

  namespace :api do
    resources :cards, only: :create
    resources :sellings, only: :update do
      post :authorize, on: :collection
    end
  end

  resources :users

  resources :suppliers do
    resources :users
    resources :supplier_requests, except: [:destroy]
  end
  resources :supplier_requests, only: [:destroy]

  resources :sessions, only: :create
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'admin', to: 'application#admin', as: :admin
  get 'profile', to:'users#edit', as: :profile

  get 'login', to: 'sessions#login_form', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout
  
  get 'no_cards_assigned', to: 'public#no_cards_assigned', as: :no_cards_assigned
  get 'terms_of_use', to: 'public#terms_of_use', as: :terms_of_use
  post 'accept_terms_of_use', to: 'public#accept_terms_of_use', as: :accept_terms_of_use
  root 'public#home'

end
