Rails.application.routes.draw do
  root 'listings#index'

  devise_for :users
  resources :listings, except: [:index]

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path

  post 'offer/:id' => 'offers#create', as: 'offer'
  patch 'offer/:id' => 'offers#update', as: 'offer_update'
end
