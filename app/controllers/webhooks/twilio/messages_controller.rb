# frozen_string_literal: true

class Webhooks::Twilio::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_twilio_request

  def create
    response = Twilio::TwiML::MessagingResponse.new
    response.message(body: generate_message(params["Body"]))

    render xml: response.to_xml
  end

  private

  def validate_twilio_request
    return if TwilioRequestValidator.valid?(request)

    head :unauthorized
  end

  def generate_message(body)
    if session[:track]
      message_for_tracked_session(body, session[:track])
    else
      message_for_untracked_session(body)
    end
  end

  def message_for_tracked_session(body, track_id)
    case ChatGpt.get_user_intent(body)
    when "positive"
      Spotify.add_to_playlist!(user: User.last, track_id: track_id)
      session[:track] = nil
      ChatGpt.generate_friendly_message("add_track")
    when "negative"
      session[:track] = nil
      ChatGpt.generate_friendly_message("not_add_track")
    else
      ChatGpt.generate_friendly_message("undetermined")
    end
  end

  def message_for_untracked_session(body)
    if track = Spotify.track_search(body)
      session[:track] = track.uri
      track_info = "#{track.name} by #{track.artists.map(&:name).to_sentence}"
      ChatGpt.generate_track_search_message("found", track_info: track_info)
    else
      ChatGpt.generate_track_search_message("not_found", body: body)
    end
  end

end
