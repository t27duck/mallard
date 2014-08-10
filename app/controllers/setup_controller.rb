class Mallard < Sinatra::Base
  get "/setup" do
    redirect to("/") if setup_complete?
    erb :"setup/index"
  end

  post "/setup" do
  end
end
