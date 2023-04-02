# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def callback
    @user = Users::Create.perform(oauth: request.env["omniauth.auth"]).user

    redirect_to edit_user_path(@user)
  end

  def final_step
  end
end
