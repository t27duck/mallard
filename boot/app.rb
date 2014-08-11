class Mallard < Sinatra::Base
  get "/" do
    redirect to("/setup") if needs_setup?(request.path)
  end
end
