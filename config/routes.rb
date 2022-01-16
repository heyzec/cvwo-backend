Rails.application.routes.draw do

  scope '/api/v1' do
    resources :tasks
    resources :tags
    resources :lists do
      post 'create', to: 'lists#create_task'
    end
    post '/signup', to: 'users#create'
    post '/signin', to: 'sessions#create'
    get '/signout', to: 'sessions#destroy'
    get '/status', to: 'sessions#index'
  end


end
