Rails.application.routes.draw do

  namespace :api do
    resources :cards, only: :create
    resources :sales, only: :update do
      post :authorize, on: :collection
      post :confirm, on: :collection
    end
  end

  resources :users do
    collection do
      get :search
    end
    member do
      patch :assign_card
      get :edit_points
      put :update_points
    end
    resources :services, except: [:index] do
      put :activate, on: :member
      put :finalize, on: :member
    end
    resources :sales, except: [:edit, :destroy, :update] do
      resources :sale_products
    end
  end

  resources :laboratories, only: [] do
    get :search, on: :collection
  end

  resources :drugs, only: [] do
    get :search, on: :collection
  end

  resources :services, only: [] do
    get :near_expiration, on: :collection
    get :history, on: :member
  end

  get 'my_purchases', to: 'sales#index'

  resources :health_insurances, only: [:show, :create, :update] do
    collection do
      get :search
    end
  end

  resources :coinsurances, only: [:show, :create, :update] do
    collection do
      get :search
    end
  end

  resources :pathologies, except: [:show]

  resources :products, except: [] do
    collection do
      get :search
      get :search_for_service
      get :new_batch_update
      post :batch_update
    end
  end

  resources :alfabeta_updates, only: [:index, :show]

  get 'rewards/:id/down_stock', to: 'rewards#down_stock', as: :reward_down_stock
  get 'rewards/:id/up_stock', to: 'rewards#up_stock', as: :reward_up_stock
  post 'rewards/down_stock_update', to: 'rewards#down_stock_update', as: :reward_down_stock_update
  post 'rewards/up_stock_update', to: 'rewards#up_stock_update', as: :reward_up_stock_update
  resources :rewards

  resources :shopping_cart_rewards, except: [:index, :new, :edit, :create, :destroy, :update] do
    get :add_item, on: :member
    get :refresh_item, on: :member
    get :delete_item, on: :member
    get :list, on: :collection
    get :shoping_cart, on: :collection
    post :confirm_shoping_cart, on: :collection
  end

  resources :reward_orders, only: [:index, :show, :destroy] do
    get :change_state, on: :member
    get :voucher_pdf, on: :member
  end

  resources :vademecums do
    get :get_suppliers, on: :member
  end

  resources :supplier_requests, except: [:destroy] do
    member do
      post :add_card
      post :emit
    end
    resources :comments, only: [:create, :index]
  end

  resources :comments, only: [:destroy]

  resources :suppliers do
    get :list_for_map, on: :collection
    get :search, on: :collection
    resources :users do
      resources :sales, except: [:edit, :destroy, :update] do
        resources :sale_products
      end
    end
    resources :supplier_requests do
      collection do
        get :document_form
        post :load_form
      end
    end
    resources :services do
      get :near_expiration, on: :collection
    end
  end

  resources :authorizations, except: [:destroy, :update, :edit, :new]

  resources :sessions, only: :create

  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'admin', to: 'application#admin', as: :admin
  get 'profile', to: 'users#edit', as: :profile

  get 'login', to: 'sessions#login_form', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout

  get 'no_cards_assigned', to: 'public#no_cards_assigned', as: :no_cards_assigned
  get 'terms_of_use', to: 'public#terms_of_use', as: :terms_of_use
  post 'accept_terms_of_use', to: 'public#accept_terms_of_use', as: :accept_terms_of_use
  root 'public#home'

end
