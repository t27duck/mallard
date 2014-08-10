class Mallard < Sinatra::Base
  get "/setup" do
    redirect to("/") if setup_complete?
    erb :"setup/index"
  end

  post "/setup" do
    password = params[:password]
    if password == params[:password_confirmation]
      flash[:notice] = "Setup complete"
      AppSetup.set_password(password)
      redirect to("/")
    else
      flash[:error] = "Passwords do not match"
      redirect to("/setup")
    end
  end
end
