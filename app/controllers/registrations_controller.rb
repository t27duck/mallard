# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :one_user_registered?, only: %i[new create]

  def cancel
    redirect_to root_path
  end

  def edit
    redirect_to root_path
  end

  def update
    redirect_to root_path
  end

  def destroy
    redirect_to root_path
  end

  protected

  def one_user_registered?
    if User.count == 1
      if user_signed_in?
        redirect_to root_path
      else
        redirect_to new_user_session_path
      end
    end
  end
end
