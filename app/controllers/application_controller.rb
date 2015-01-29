get "/" do
  @entries = EntryRepo.unread
  @page_title = I18n.translate("titles.unread_entries")
  @active_menu = :unread_entires
  erb :root
end

get "/starred" do
  @entries = EntryRepo.starred
  @page_title = I18n.translate("titles.starred_entries")
  @active_menu = :starred_entires
  erb :root
end

get "/read" do
  @entries = EntryRepo.read(:search => params[:search]).paginate(:page => params[:page])
  @page_title = I18n.translate("titles.read_entries")
  @active_menu = :read_entires
  @show_pagination = true
  @show_search_form = true
  erb :root
end
