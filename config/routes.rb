# frozen_string_literal: true

Rails.application.routes.draw do
  resources :artists
  resources :lps

  # Ruta para el reporte consolidado
  get 'reports', to: 'reports#index', as: 'reports'

  # Ruta de health check
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Ruta principal
  root 'home#index'
end
