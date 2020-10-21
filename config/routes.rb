Rails.application.routes.draw do

  root 'top_page#home'
  get '/about', to: 'top_page#about'
  get '/contact', to: 'top_page#contact'
  get '/signup', to: 'users#new'
  resources :users
  
end