# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  before_action :one_user_registered?, only: %i[new create]
  before_action :configure_permitted_parameters

  protected

  def one_user_registered?
    redirect_to new_registration_path if User.count.zero?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:username, :remember_me, :password)
    end
  end
end
