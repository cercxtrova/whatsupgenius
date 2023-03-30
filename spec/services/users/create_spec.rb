# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::Create do
  let(:oauth_params) do
    {
      "id"          => "spotify_user_id",
      "credentials" => {
        "token"         => "spotify_user_token",
        "refresh_token" => "spotify_user_refresh_token",
      },
    }
  end

  let(:playlist) { double("Playlist", id: "playlist_id") }
  let(:spotify_user) { double("SpotifyUser", id: "spotify_user_id", credentials: oauth_params["credentials"]) }

  before do
    allow(RSpotify::User).to receive(:new).and_return(spotify_user)
    allow(spotify_user).to receive(:create_playlist!).and_return(playlist)
  end

  it "creates a user with the given OAuth data" do
    user = Users::Create.new(oauth_params).perform.user

    expect(user.spotify_user_id).to eq("spotify_user_id")
    expect(user.spotify_user_token).to eq("spotify_user_token")
    expect(user.spotify_user_refresh_token).to eq("spotify_user_refresh_token")
    expect(user.spotify_playlist_id).to eq("playlist_id")
  end
end
