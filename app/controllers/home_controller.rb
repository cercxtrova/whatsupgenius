# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def callback
    @user = Users::Create.new(request.env["omniauth.auth"]).perform.user
  end
end
