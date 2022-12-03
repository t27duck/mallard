# frozen_string_literal: true

Rails.application.routes.draw do
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
