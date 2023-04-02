# frozen_string_literal: true

class User < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  validates :phone, presence: true, on: :update

  def to_param
    token
  end

end
