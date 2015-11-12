Rails.application.routes.draw do

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
  
  root 'application#home'

end
