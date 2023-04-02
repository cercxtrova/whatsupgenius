# frozen_string_literal: true

module Users
  class Create
    include Performable

    attr_accessor :user

    def initialize(oauth:)
      @oauth = oauth
    end

    def perform
      find_spotify_user
      create_user!
      create_playlist!
      self
    end

    private

    attr_accessor :spotify_user

    def find_spotify_user
      self.spotify_user = RSpotify::User.new(@oauth)
    end

    def create_user!
      self.user = User.create!(
        token:                      SecureRandom.hex(10),
        spotify_user_id:            spotify_user.id,
        spotify_user_token:         spotify_user.credentials["token"],
        spotify_user_refresh_token: spotify_user.credentials["refresh_token"]
      )
    end

    def create_playlist!
      playlist = spotify_user.create_playlist!("WhatsUpgenius", public: false)
      user.update_columns(spotify_playlist_id: playlist.id)
    end

  end
end
