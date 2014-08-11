class Mallard < Sinatra::Base
  register Sinatra::AssetPack
  register Sinatra::ActiveRecordExtension
  register Sinatra::Contrib
  register Sinatra::Flash
  register Sinatra::Reloader
end
