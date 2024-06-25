# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  resources :data_crumbs

  get 'up' => 'rails/health#show', as: :rails_health_check
end
