class Mallard < Sinatra::Base
  get "/setup" do
    redirect to("/") if setup_complete?
    erb :"setup/index"
  end

  post "/setup" do
    password = params[:password]
    if password == params[:password_confirmation]
      flash[:info] = I18n.translate("flash.setup.complete")
      AppSetup.set_password(password)
      redirect to("/")
    else
      flash[:danger] = I18n.translate("flash.setup.passwords_do_not_match")
      redirect to("/setup")
    end
  end
end
