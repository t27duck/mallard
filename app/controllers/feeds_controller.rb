class Mallard < Sinatra::Base
  get "/feeds" do
    @feeds = Decorator.generate(FeedRepo.all)
    erb :"feeds/index"
  end

  get "/feeds/new" do
    @feed = Feed.new
    erb :"feeds/new"
  end

  post "/feeds" do
    @feed = FeedRepo.create(params[:url], params[:sanitize])
    if @feed.valid?
      flash[:info] = "Feed created"
      redirect to("/feeds")
    else
      flash[:danger] = "Unable to add feed"
      erb :"feeds/new"
    end
  end

  get "/feeds/:id/edit" do
    @feed = FeedRepo.find(params[:id])
    erb :"feeds/edit"
  end

  put "/feeds/:id" do
    FeedRepo.update(FeedRepo.find(params[:id]), params[:title], params[:sanitize])
    flash[:info] = "Feed updated"
    redirect to("/feeds")
  end

  delete "/feeds/:id" do
    @feed = FeedRepo.find(params[:id])
    @feed.destroy
    flash[:info] = "Feed deleted"
    redirect to("/feeds")
  end
end
