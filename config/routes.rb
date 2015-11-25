Rails.application.routes.draw do

  namespace :api do
    resources :cards, only: :create
    resources :sales, only: :update do
      post :authorize, on: :collection
    end
  end
  
  resources :users do
    resources :services, except: [:index]
    patch :assign_card, on: :member
    resources :sales, except: [:edit, :destroy, :create] do
      resources :sale_products
    end
  end

  resources :products, except: [:show] do
    collection do
      get :search
      get :search_for_service
    end
    
  end
  resources :rewards
  resources :vademecums
  
  resources :supplier_requests do
    post :add_card, on: :member
    resources :comments, only: [:create, :index]
  end

  resources :comments, only: [:destroy]
  
  resources :suppliers do
    resources :users
    resources :supplier_requests do
      collection do
        get :document_form
        post :load_form
      end
    end
  end

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