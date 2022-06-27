# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
                       sessions: "sessions"
                     }, skip: [:registrations]
  devise_scope :user do
    # Rebuilds the registration paths without the cancel or destroy endpoints
    resource :registration, only: [:new, :create], controller: "registrations"
  end

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
