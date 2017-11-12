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

  # Need forms for creating new password resets and for updating them by changing the password
  # in the user model. So create routes for new, create, edit, and update through resources. 
  # HTTP REQUEST - URL - ACTION - NAMED ROUTE 
  # GET - /password_resets/new - new - new_password_reset_path
  # POST - /password_resets/create - create - create_password_reset_path
  # GET - /password_resets/<token>/edit - edit - edit_password_reset_path(token)
  # POST - /password_resets/<token> - update - update_password_reset_url(token)
  resources :password_resets, only: [:new, :create, :edit, :update]
end
