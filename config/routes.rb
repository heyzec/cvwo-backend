Rails.application.routes.draw do
  scope '/api/v1' do
    resources :tasks
  end
  scope '/api/v1' do
    resources :tags
  end
end
