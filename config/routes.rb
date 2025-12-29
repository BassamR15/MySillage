Rails.application.routes.draw do

  # Redirect to localhost from 127.0.0.1 to use same IP address with Vite server
  constraints(host: "127.0.0.1") do
    get "(*path)", to: redirect { |params, req| "#{req.protocol}localhost:#{req.port}/#{params[:path]}" }
  end
  get 'inertia-example', to: 'inertia_example#index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # collection et scent profile et smells user badges dans profile ?
  
  resources :perfumes, only: [:show, :index] do
    resources :reviews, only: [:create, :destroy]
    resources :season_votes, only: [:create, :destroy]
    resource :wishlist, only: [:create, :destroy]
    resource :collection, only: [:create]
    resource :price_alert, only: [:create, :destroy]
  end

  resources :wishlists, only: [:index]

  resources :verifications, only: [:new, :create, :index, :destroy]
  resources :brands, only: [:index, :show]
  resources :perfumers, only: [:index, :show]
  resources :marketplace_profiles, only: [:show]
  resources :notes, only: [:show, :index]

  resources :notifications, only: [:index, :show, :destroy]

  resources :conversations, only: [:show] do
    resources :messages, only: [:create, :update, :destroy]
    resources :offers, only: [:create, :update, :destroy] do
      resources :offer_items, only:[:create]
    end
  end

  resources :layerings, only: [:new, :create, :destroy]

  resources :price_alerts, only: [:new, :create, :destroy, :index]

  resources :listings do
    resources :orders, only: [:show] do
      resources :disputes, only: [:new, :create, :show, :destroy]
    end
  end

  resources :marketplace_profiles, except: [:index]
  # favorite et seller reviews dans market place profiles

  resources :ai_conversations, only: [:show, :create, :destroy] do
    resources :ai_messages, only: [:create]
  end

  namespace :api do
    get "search", to: "search#search"
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
