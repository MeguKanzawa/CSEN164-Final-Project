Rails.application.routes.draw do
  resources :reviews
  get "signup", to: 'users#new', as: :signup
  resources :users, only: [:create]
  
  resource :session
  resources :passwords, param: :token
  resources :orders
  resources :cartitems
  resources :carts
  get "shopper/index"
  resources :products do
    resources :reviews, only: [:create, :edit, :update, :destroy]
  end

  root "shopper#index"
  get "/", to: 'shopper#index', as: 'shopper'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
