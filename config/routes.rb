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
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end