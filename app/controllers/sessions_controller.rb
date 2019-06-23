# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  before_action :one_user_registered?, only: %i[new create]

  protected

  def one_user_registered?
    redirect_to new_user_registration_path if User.count.zero?
  end
end
