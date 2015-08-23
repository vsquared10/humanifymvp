Rails.application.routes.draw do
  root 'listings#index'

  devise_for :users

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path

  get 'users/:id/:name' => 'users#show', as: 'user_profile'

  resources :listings, except: [:index]
  resources :listing_offers, only: [:create]
  resources :listing_asks, only: [:create]
  resources :listing_communities, only: [:create]

  resources :offers, only: [:create, :update]
  resources :reviews, except: [:index,:show]

  resources :inbox, except: [:new]
  get '/inbox/:id/new' => 'inbox#new', as: 'new_inbox'

  resources :notifications, only: [:index]

  get 'notification/delete' => 'notification#delete'


  # Pusher Auth Endpoint
  # 'pusher/auth' => 'pusher#auth'
  # catch all => homepage
end
