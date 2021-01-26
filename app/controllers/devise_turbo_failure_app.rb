# frozen_string_literal: true

# From https://gorails.com/episodes/devise-hotwire-turbo
# These custom "controllers" enables the default turbo stream responses to work with devise
class DeviseTurboFailureApp < Devise::FailureApp
  def respond
    if request_format == :turbo_stream
      redirect
    else
      super
    end
  end

  def skip_format?
    ["html", "turbo_stream", "*/*"].include?(request_format.to_s)
  end
end
