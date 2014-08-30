class Mallard < Sinatra::Base
  get "/" do
    @entries = Decorator.generate(EntryRepo.unread)
    @page_title = I18n.translate("titles.unread_entries")
    @active_menu = :unread_entires
    erb :root
  end

  get "/starred" do
    @entries = Decorator.generate(EntryRepo.starred)
    @page_title = I18n.translate("titles.starred_entries")
    @active_menu = :starred_entires
    erb :root
  end

  get "/read" do
    @entries = Decorator.generate(EntryRepo.read)
    @page_title = I18n.translate("titles.read_entries")
    @active_menu = :read_entires
    erb :root
  end
end
