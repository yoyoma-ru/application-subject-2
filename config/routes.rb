Rails.application.routes.draw do
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update, :followring, :followers] do
  	member do
  		get :following, :followers
  	end
  end
  resources :relationships, only: [:create, :destroy]
  resources :books

end