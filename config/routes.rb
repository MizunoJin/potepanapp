Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'top_page#home'
  get '/about', to: 'top_page#about'
  get '/contact', to: 'top_page#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'users#facebook_login', as: :auth_callback
  get '/auth/failure',  to: 'users#auth_failure',  as: :auth_failure
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts do
    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
  resources :users
  get "users/:id/likes" => "users#likes"
  get "users/:id/password_edit" => "users#password_edit"
  patch "users/:id/password_update" => "users#password_update"
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts do
    resources :comments
  end
  resources :microposts do
    get :search, on: :collection
  end
  resources :relationships,       only: [:create, :destroy]
  resources :notifications, only: :index
end