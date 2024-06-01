# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :one_user_registered?

  def new
  end

  def create
    user = User.take

    if user&.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path
    else
      flash.now.alert = translate("flash.incorrect_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to root_path, status: :see_other
  end

  protected

  def one_user_registered?
    redirect_to setup_path if User.count.zero?
  end
end
