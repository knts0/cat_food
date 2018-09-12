Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, format: 'json' do
    resources :logs, only: [:index, :create, :update, :destroy]
  end
end
