Rails.application.routes.draw do

  scope '/api/v1' do

    resources :tasks
    resources :tags
    resources :lists do
      post 'create', to: 'lists#create_task'
    end

    post 'signup', to: 'users#create'
    post 'signin', to: 'sessions#create'
    get 'signout', to: 'sessions#destroy'
    get 'status', to: 'sessions#index'
    
    scope 'auth' do
      get 'github', to: 'auth#callback_github'
      get 'google', to: 'auth#callback_google'
    end
  end
  
end
