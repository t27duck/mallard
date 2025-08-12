# frozen_string_literal: true

class SessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  before_action :one_user_registered?

  rate_limit to: 10, within: 3.minutes, only: :create, with: lambda {
    redirect_to new_session_url, alert: translate("flash.incorrect_password")
  }

  def new
  end

  def create
    user = User.take
    if user&.authenticate(params.expect(:password))
      start_new_session_for user
      redirect_to root_path
    else
      redirect_to new_session_url, alert: translate("flash.incorrect_password")
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, status: :see_other
  end

  private

  def one_user_registered?
    redirect_to setup_path if User.none?
  end
end
