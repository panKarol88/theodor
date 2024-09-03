# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :data_crumbs
  resources :warehouses, only: %i[show]
  resources :workflows, only: %i[show] do
    member do
      get :new_feature
      post :create_feature
      post :process_input
    end
  end
  get 'workflows/:id/features/:feature_id', to: 'workflows#show_feature'
  delete 'workflows/:id/workflows_features/:workflows_feature_id', to: 'workflows#delete_workflows_feature'

  resources :prompt_decorators, only: %i[destroy edit update new create]
  resources :features, only: %i[show]

  get 'up' => 'rails/health#show', as: :rails_health_check

  mount Theodor::API => '/api/'
end
