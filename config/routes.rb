Rails.application.routes.draw do

  root 'top_page#home'
  get '/about', to: 'top_page#about'
  get '/contact', to: 'top_page#contact'
  get '/signup', to: 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
