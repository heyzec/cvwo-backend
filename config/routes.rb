Rails.application.routes.draw do

  scope '/api/v1' do
    resources :tasks
    resources :tags
    post '/signup', to: 'users#create'
    post '/signin', to: 'sessions#create'
    get '/signout', to: 'sessions#destroy'
    get '/status', to: 'sessions#index'
  end


end
