Rails.application.routes.draw do
  devise_for :users
  resources :apartments

  resources :users, :only => [:show]
  
  get 'pages/contacts'
  get 'pages/about'
  
  get "about", to: "pages#about"
  get "contacts", to: "pages#contacts"

  # CSP violation reports
  post '/csp_violation_report_endpoint', to: 'csp_reports#create'

  root "apartments#index"
end
