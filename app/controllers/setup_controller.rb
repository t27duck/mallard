class Mallard < Sinatra::Base
  get "/setup" do
    erb :"setup/index"
  end

  post "/setup" do
  end
end
