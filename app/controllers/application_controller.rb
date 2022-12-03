# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :user_signed_in?

  private

  def sign_in(user)
    cookies.encrypted[:signin] = { value: user.token, expires: 1.year, httponly: true }
  end

  def user_signed_in?
    @user_signed_in ||= User.exists?(token: cookies.encrypted[:signin])
  end

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end
end
