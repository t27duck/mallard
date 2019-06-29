# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

  resources :feeds, only: %i[create update destroy] do
    collection do
      get :list
    end
    member do
      get :fetch
    end
  end

  resources :entries, only: %i[show update] do
    collection do
      get :unread
      get :read
      get :starred
    end
  end

  get "/:page", to: "site#index"

  root "site#index"
end
