# frozen_string_literal: true

module Performable
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  class_methods do
    def perform(**args)
      new(**args).tap(&:perform)
    end
  end

  def perform
    raise NotImplementedError
  end

  def fail!(message)
    errors.add(:base, message)
  end

  def error?
    errors.any?
  end

  def error_message
    errors.full_messages.join(", ")
  end

  def success?
    errors.none?
  end
end
