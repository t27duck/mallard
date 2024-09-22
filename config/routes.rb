# frozen_string_literal: true

Rails.application.routes.draw do
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", :as => :pwa_service_worker
  get "serviceWorker" => "rails/pwa#service_worker", :as => :pwa_service_worker_alt
  get "manifest" => "rails/pwa#manifest", :as => :pwa_manifest

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
