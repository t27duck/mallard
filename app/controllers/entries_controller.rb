class Mallard < Sinatra::Base
  get "/entries/:id" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.read(@entry)
    erb :"entries/show"
  end

  get "/entries/:id/star" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.star(@entry)
    "ok"
  end

  get "/entries/:id/unstar" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.unstarr(@entry)
    "ok"
  end

  get "/entries/:id/read" do
    @entry = EntryRepo.find(params[:id])
    EntryRepo.read(@entry)
    "ok"
  end

  get "/entries/:id/unread" do
    @entry = Entry.find(params[:id])
    EntryRepo.unread(@entry)
    "ok"
  end
end
