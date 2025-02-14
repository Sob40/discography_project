# frozen_string_literal: true

Rails.application.routes.draw do
  resources :artists
  resources :lps
  resources :authors

  resources :reports, only: [:index]
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
