# frozen_string_literal: true

class Webhooks::Twilio::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_twilio_request

  def create
    response = Twilio::TwiML::MessagingResponse.new
    response.message(body: "Hello World")
    render xml: response.to_xml
  end

  private

  def validate_twilio_request
    return if TwilioRequestValidator.valid?(request)

    head :unauthorized
  end

end
