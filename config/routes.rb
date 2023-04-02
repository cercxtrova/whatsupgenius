# frozen_string_literal: true
Rails.application.routes.draw do
  root "home#index"

  controller :home do
    get :index
    get :final_step
    get "/auth/spotify/callback", to: "home#callback"
  end

  resources :users, only: %i[edit update], param: :token

  namespace :webhooks do
    namespace :twilio do
      post "messages", to: "messages#create"
    end
  end

end
