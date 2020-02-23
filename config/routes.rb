Rails.application.routes.draw do
  get "home/about" => "homes#about"
  root :to => 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
end
