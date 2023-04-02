# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to final_step_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by!(token: params[:token])
  end

  def user_params
    params.require(:user).permit(:phone)
  end
end
