class Mallard < Sinatra::Base
  configure do
    error ActiveRecord::RecordNotFound do
      status 404
      body "Not found!"
    end
  end
end
