# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def callback
    @spotify_user = RSpotify::User.new(request.env["omniauth.auth"])
    @new_playlist = @spotify_user.create_playlist!("WhatsUpgenius", public: false)
  end
end
