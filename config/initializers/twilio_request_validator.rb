# frozen_string_literal: true

require "twilio-ruby"
require "byebug"

module TwilioRequestValidator
  def self.valid?(request)
    params = request.request_parameters.clone
    params.delete("controller")
    params.delete("action")

    Twilio::Security::RequestValidator.new(Rails.application.credentials[:twilio][:auth_token])
      .validate(
        request.original_url,
        params,
        request.headers["X-Twilio-Signature"]
      )
  end
end
