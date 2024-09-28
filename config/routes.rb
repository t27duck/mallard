# frozen_string_literal: true

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", :as => :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "serviceWorker" => "rails/pwa#service_worker", :as => :pwa_service_worker_alt

  resource :setup, only: [:show, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :feeds do
    member do
      get :fetch
    end
  end

  resources :entries, only: [:update] do
    collection do
      get :unread
      get :read
      get :starred
    end
  end

  root "entries#unread"
end
