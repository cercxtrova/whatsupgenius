# frozen_string_literal: true

class Webhooks::Twilio::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_twilio_request

  def create
    body = params["Body"]
    spotify = Spotify.new
    track = spotify.track_search(body)

    if session[:track]
      answer = body.split(" ").first.downcase.strip
      if answer == "yes"
        message = "OK, adding that track now."
        spotify.add_to_playlist(user: User.last, track_id: session[:track])
        session[:track] = nil
      elsif answer == "no"
        session[:track] = nil
        message = "What do you want to add?"
      end
    end

    if !message
      track = spotify.track_search(body)
      if track
        session[:track] = track.uri
        message = "Did you want to add _#{track.name}_ by _#{track.artists.map(&:name).to_sentence}_?"
      else
        message = "I couldn't find any songs by searching for '#{body}'. Try something else."
      end
    end

    response = Twilio::TwiML::MessagingResponse.new
    response.message(body: message)

    render xml: response.to_xml
  end

  private

  def validate_twilio_request
    return if TwilioRequestValidator.valid?(request)

    head :unauthorized
  end

end
