class Mallard < Sinatra::Base
  get "/" do
    @entries = Decorator.generate(EntryRepo.unread)
    erb :root
  end
end
