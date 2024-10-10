# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication

  around_action :switch_locale

  helper_method :stats

  private

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
