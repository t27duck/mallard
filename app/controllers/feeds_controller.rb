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
      flash[:info] = I18n.translate("flash.feed.created")
      EntryFetcher.new(@feed).fetch
      redirect to("/feeds")
    else
      flash[:danger] = I18n.translate("flash.feed.created_error")
      erb :"feeds/new"
    end
  end

  get "/feeds/:id/edit" do
    @feed = FeedRepo.find(params[:id])
    erb :"feeds/edit"
  end

  put "/feeds/:id" do
    FeedRepo.update(FeedRepo.find(params[:id]), params[:title], params[:sanitize])
    flash[:info] = I18n.translate("flash.feed.updated")
    redirect to("/feeds")
  end

  delete "/feeds/:id" do
    @feed = FeedRepo.find(params[:id])
    @feed.destroy
    flash[:info] = I18n.translate("flash.feed.delete")
    redirect to("/feeds")
  end

  get "/feeds/:id/fetch" do
    @feed = FeedRepo.find(params[:id])
    EntryFetcher.new(@feed).fetch
    flash[:info] = I18n.translate("flash.feed.fetched", :feed => @feed.title)
    redirect to("/feeds")
  end
end
