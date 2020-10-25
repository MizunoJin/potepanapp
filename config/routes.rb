Rails.application.routes.draw do

  root 'top_page#home'
  get '/about', to: 'top_page#about'
  get '/contact', to: 'top_page#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
end