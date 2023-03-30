# frozen_string_literal: true
Rails.application.routes.draw do
  root "home#index"

  controller :home do
    get :index
    get "/auth/spotify/callback", to: "home#callback"
  end

end
