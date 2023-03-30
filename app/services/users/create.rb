# frozen_string_literal: true

module Users
  class Create
    attr_accessor :user

    def initialize(oauth_params)
      @oauth_params = oauth_params
    end

    def perform
      find_spotify_user
      create_user!
      create_playlist!
      update_user!
      self
    end

    private

    attr_accessor :spotify_user, :playlist

    def find_spotify_user
      self.spotify_user = RSpotify::User.new(@oauth_params)
    end

    def create_user!
      self.user = User.create!(
        spotify_user_id:            spotify_user.id,
        spotify_user_token:         spotify_user.credentials["token"],
        spotify_user_refresh_token: spotify_user.credentials["refresh_token"]
      )
    end

    def create_playlist!
      self.playlist = spotify_user.create_playlist!("WhatsUpgenius", public: false)
    end

    def update_user!
      user.update!(spotify_playlist_id: playlist.id)
    end

  end
end
