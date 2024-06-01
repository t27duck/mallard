# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :switch_locale

  helper_method :user_signed_in?, :stats

  private

  def sign_in(user)
    cookies.signed.permanent[:signin] = { value: user.token, httponly: true, same_site: :lax }
  end

  def sign_out
    cookies.delete(:signin)
    reset_session
  end

  def user_signed_in?
    @user_signed_in ||= User.exists?(token: cookies.signed[:signin])
  end

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

  def stats
    @stats ||= Entry.stats
  end

  def sticky_navbar
    @sticky_navbar = true
  end

  def switch_locale(&action)
    locale = ENV["MALLARD_LOCALE"].presence || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
