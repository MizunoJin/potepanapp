Rails.application.routes.draw do
  root 'top_page#home'
  get 'top-page/home'
  get 'top_page/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
