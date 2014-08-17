class Mallard < Sinatra::Base
  get "/feeds" do
    @feeds = FeedRepo.all
    erb :"feeds/index"
  end

  get "/feeds/new" do
    @feed = Feed.new
    erb :"feeds/new"
  end

  post "/feeds" do
    url       = params[:url]
    sanitize  = params[:sanitize]
    @feed = FeedRepo.create(url, sanitize)
    if @feed.valid?
      flash[:notice] = "Feed created"
      redirect to("/feeds")
    else
      erb :"feeds/new"
    end
  end

  get "/feeds/:id/edit" do
    @feed = Feed.find(params[:id])
    erb :"feeds/edit"
  end

  put "/feeds/:id" do
    id      = params[:id]
    title   = params[:title]
    santize = params[:sanitize]
    FeedRepo.update(FeedRepo.find(id), title, santize)
    flash[:notice] = "Feed updated"
    redirect to("/feeds")
  end

  delete "/feeds/:id" do
    @feed = FeedRepo.find(params[:id])
    @feed.destroy
    flash[:notice] = "Feed deleted"
    redirect to("/feeds")
  end
end
