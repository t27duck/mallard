get "/entries/:id" do
  @entry = Decorator.generate(EntryRepo.find(params[:id]))
  EntryRepo.update(@entry, {:read => true})
  erb :"entries/show", :layout => false
end

put "/entries/:id" do
  @entry = EntryRepo.find(params[:id])
  EntryRepo.update(@entry, params[:entry])
  "ok"
end
