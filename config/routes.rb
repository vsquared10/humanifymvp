Rails.application.routes.draw do
  root 'listings#index'

  devise_for :users
  resources :listings

  get 'about' => 'pages#about' #create about_path
  get 'profile' => 'pages#profile' #create profile_path
end
