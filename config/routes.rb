Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  root to: 'home#index'

  namespace :api, format: 'json' do
    resources :logs, only: [:index, :create, :update, :destroy]
  end
end
