Rails.application.routes.draw do
  root 'listings#index'

  resources :listings
  devise_for :users

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path
end
