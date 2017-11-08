Rails.application.routes.draw do
  root 'static_pages#home'
  get     '/help',     to: 'static_pages#help'
  get     '/about',    to: 'static_pages#about'
  get     '/contact',  to: 'static_pages#contact'
  get     '/signup',   to: 'users#new'
  post    '/signup',   to: 'users#create'
  get     '/login',    to: 'sessions#new'
  post    '/login',    to: 'sessions#create'
  delete  '/logout',   to: 'sessions#destroy'
  resources :users #endows the application with all the actions needed for a RESTful Users Resouce
  
  # create a named RESTful route for the EDIT action: 
  # HTTP request: GET, URL: /account_activation/<token>/edit, Action: EDIT
  # named RESTful route: edit_account_activation_url(token)
  resources :account_activations, only: [:edit] 
end
