# frozen_string_literal: true

require "rspotify/oauth"

client_id = Rails.application.credentials[:spotify][:client_id]
client_secret = Rails.application.credentials[:spotify][:client_secret]

RSpotify.authenticate(client_id, client_secret)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:spotify, client_id, client_secret, scope: "playlist-modify-private")
end
