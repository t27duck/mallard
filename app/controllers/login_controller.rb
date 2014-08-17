class Mallard < Sinatra::Base
  get "/login" do
    redirect to("/") if logged_in?
    erb :"login/index"
  end

  post "/login" do
    redirect to("/") if logged_in?
    if authenticate(params[:password])
      redirect to("/")
    else
      erb :"login/index"
    end
  end
end
