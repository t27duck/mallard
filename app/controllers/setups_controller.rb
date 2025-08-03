# frozen_string_literal: true

class SetupsController < ApplicationController
  allow_unauthenticated_access only: [:show, :create]

  before_action :one_user_registered?

  def show
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: translate("flash.setup_complete")
    else
      render :show, status: :unprocessable_content
    end
  end

  protected

  def user_params
    params.expect(user: [:password, :password_confirmation])
  end

  def one_user_registered?
    return false unless User.count == 1

    if authenticated?
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end
end
