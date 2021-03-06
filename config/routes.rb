Rails.application.routes.draw do
  scope '/api/v1' do

    resources :tasks
    resources :tags
    resources :lists do
      post 'create', to: 'lists#create_task'
      post 'share', to: 'shares#share_list'
    end
    
    get 'share/:hash', to: 'shares#index'
    post 'share/:hash', to: 'shares#create'

    post 'signin', to: 'sessions#create'
    get 'signout', to: 'sessions#destroy'
    get 'status',  to: 'sessions#index'                 # For frontend to check if they are logged in
    
    post 'signup',         to: 'users#create'
    get 'user',            to: 'users#index'            # Retrieve user settings
    post 'changepassword', to: 'users#changepassword'
    post 'changeemail',    to: 'users#changeemail'
    post 'closeaccount',   to: 'users#destroy'
    
    scope 'auth' do
      get 'github', to: 'auth#callback_github'
      get 'google', to: 'auth#callback_google'
    end
    
  end
end
