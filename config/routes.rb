# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

  resources :feeds, only: %i[create destroy] do
    collection do
      get :list
    end
    member do
      get :fetch
    end
  end

  get "/:page", to: "site#index"

  root "site#index"
end
