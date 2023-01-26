Rails.application.routes.draw do
  devise_for :users
  resources :apartments

  resources :users, :only => [:show]
  
  get 'pages/contacts'
  get 'pages/about'
  
  get "about", to: "pages#about"
  get "contacts", to: "pages#contacts"

  root "apartments#index"
end
