# frozen_string_literal: true

class Spotify
  def self.track_search(query)
    RSpotify::Track.search(query).first
  end

  def self.add_to_playlist!(user:, track_id:)
    RSpotify::Playlist.find(user.spotify_user_id, user.spotify_playlist_id)
      .add_tracks!([track_id])
  end
end
