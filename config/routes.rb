# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :data_crumbs
  resources :warehouses, only: %i[show]
  resources :prompt_decorators, only: %i[destroy edit update new create]
  resources :features, only: %i[show]

  get 'up' => 'rails/health#show', as: :rails_health_check

  mount Theodor::API => '/api/'
end
