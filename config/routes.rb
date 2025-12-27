Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :perfumes, only: [:show]
  resources :brands, only: [:index, :show]
  resources :perfumers, only: [:index, :show]
  resources :marketplace_profiles, only: [:show]

  resources :conversations, only: [:show] do
    resources :messages, only: [:create, :update, :destroy]
    resources :offers, only: [:create, :update, :destroy] do
      resources :offer_items, only:[:create]
    end
  end

  resources :layerings, only: [:new, :create, :destroy]

  resources :favourites, only: [:show]

  resources :listings do
    resources :orders, only: [:show] do
      resources :disputes, only: [:new, :create, :show, :destroy]
    end
  end

  resources :marketplace_profiles, except: [:index]


  resources :ai_conversations, only: [:show, :create, :destroy] do
    resources :ai_messages, only: [:create]
  end

  namespace :api do
    get "search", to: "search#search"
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
