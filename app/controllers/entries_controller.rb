class Mallard < Sinatra::Base
  get "/entries/:id" do
    @entry = Entry.find(params[:id])
    @entry.update_attributes!(:read => true)
    erb :"entries/show"
  end

  get "/entries/:id/star" do
    @entry = Entry.find(params[:id])
    @entry.update_attributes!(:starred => true)
    "ok"
  end

  get "/entries/:id/unstar" do
    @entry = Entry.find(params[:id])
    @entry.update_attributes!(:starred => false)
    "ok"
  end

  get "/entries/:id/read" do
    @entry = Entry.find(params[:id])
    @entry.update_attributes!(:read => true)
    "ok"
  end

  get "/entries/:id/unread" do
    @entry = Entry.find(params[:id])
    @entry.update_attributes!(:read => false)
    "ok"
  end
end
