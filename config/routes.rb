Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  root 'home#index'

  get '/bittrex', to: 'platforms#bittrex'
  get '/coin_mining_info', to: 'mining_info#show_mining_status'
  get '/calculator_rewards', to: 'mining_info#calculator_rewards'
  resources :dashboard
  resources :charging
  resources :conditions, path: :alerts
  resource :settings do
    member do
      patch :update_email
      patch :update_password
    end
  end
  get '/live_price', to: 'live_price#index'
  get '/live_prices', to: 'live_price#show_price'
  post '/charging/napcard', to: 'charging#nap_the'

end