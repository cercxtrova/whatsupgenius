# frozen_string_literal: true

class ChatGpt
  def self.generate_track_search_message(intent, body: nil, track_info: nil)
    prompt = I18n.t("chat_gpt.track_search", intent: intent, body: body, track_info: track_info)
    response = chat_gpt_response(prompt)

    response.parsed_response["choices"].first["text"].strip
  end

  def self.get_user_intent(message)
    prompt = I18n.t("chat_gpt.get_user_intent", message: message)
    response = chat_gpt_response(prompt)

    response.parsed_response["choices"].first["text"].strip.downcase
  end

  def self.generate_friendly_message(intent)
    prompt = I18n.t("chat_gpt.generate_friendly_message", intent: intent)
    response = chat_gpt_response(prompt)

    response.parsed_response["choices"].first["text"].strip
  end

  private

  def self.chat_gpt_response(prompt)
    OpenAI::Client.new.completions(
      parameters: {
        model:       "text-davinci-003",
        prompt:      prompt,
        max_tokens:  100,
        temperature: 0.7,
      }
    )
  end
end
