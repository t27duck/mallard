class Mallard < Sinatra::Base
  get "/feeds" do
    @feeds = Feed.all
    erb :"feeds/index"
  end

  get "/feeds/new" do
    @feed = Feed.new
    erb :"feeds/new"
  end

  post "/feeds" do
    @feed = Feed.new(params[:feed])
    if @feed.save
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
    @feed = Feed.find(params[:id])
    if @feed.update_attributes(params[:feed])
      flash[:notice] = "Feed updated"
      redirect to("/feeds")
    else
      erb :"feeds/edit"
    end
  end

  delete "/feeds/:id" do
    @feed = Feed.find(params[:id])
    @feed.destroy
    flash[:notice] = "Feed deleted"
    redirect to("/feeds")
  end
end
