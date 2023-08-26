# frozen_string_literal: true

class SetupsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :one_user_registered?

  def show
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  protected

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def one_user_registered?
    return false unless User.count == 1

    if user_signed_in?
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end
end
