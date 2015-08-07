Rails.application.routes.draw do
  root 'listings#index'

  devise_for :users
  resources :listings, except: [:index]

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path

  resources :offers, only: [:create, :update]

  resources :notifications, only: [:index]
  resources :inbox, only: [:index]

  # Mail Endpoints
  resources :mailbox, only: [:index]

  get 'notification/delete' => 'notification#delete'

  #Pusher Auth Endpoint
  #'pusher/auth' => 'pusher#auth'
  # catch all => homepage
end
