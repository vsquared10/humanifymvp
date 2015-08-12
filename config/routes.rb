Rails.application.routes.draw do
  root 'listings#index'

  devise_for :users

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path

  resources :listings, except: [:index]

  resources :listing_offers, only: [:create]
  resources :listing_asks, only: [:create]
  resources :listing_communities, only: [:create]

  resources :offers, only: [:create, :update]
  resources :notifications, only: [:index]
  resources :inbox, only: [:index]

  resources :reviews, only: [:create]

  # Mail Endpoints
  resources :mailbox, only: [:index]

  get 'notification/delete' => 'notification#delete'

  # Pusher Auth Endpoint
  # 'pusher/auth' => 'pusher#auth'
  # catch all => homepage
end
