Rails.application.routes.draw do
  root 'listings#index'

  devise_for :users

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path

  get 'users/:id/:name' => 'users#show'

  resources :listings, except: [:index]
  resources :listing_offers, only: [:create]
  resources :listing_asks, only: [:create]
  resources :listing_communities, only: [:create]

  resources :offers, only: [:create, :update]
  resources :reviews, except: [:index,:show]

  resources :inbox
  resources :notifications, only: [:index]

  get 'notification/delete' => 'notification#delete'


  # Pusher Auth Endpoint
  # 'pusher/auth' => 'pusher#auth'
  # catch all => homepage
end
