class Mallard < Sinatra::Base
  get "/entries/:id" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.mark_read(@entry)
    erb :"entries/show"
  end

  get "/entries/:id/star" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.mark_star(@entry)
    "ok"
  end

  get "/entries/:id/unstar" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.mark_unstarr(@entry)
    "ok"
  end

  get "/entries/:id/read" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.mark_read(@entry)
    "ok"
  end

  get "/entries/:id/unread" do
    @entry = Entry.find(params[:id])
    EntryRepo.mark_unread(@entry)
    "ok"
  end
end
