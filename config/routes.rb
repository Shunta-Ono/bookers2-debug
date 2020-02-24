Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  get "home/about" => "homes#about"
  root :to => 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
  end
end
