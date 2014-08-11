class Mallard < Sinatra::Base
  configure do
    enable :method_override
    enable :logging
    enable :sessions
    
    set :public_dir, "public"
    set :root, File.dirname(__FILE__)
    set :session_secret, ENV["SESSION_TOKEN"] || "8675309LetsGo!"
    set :views, "app/views"

    assets do
      css_compression :simple

      css :application, [
        "/css/bootstrap.min.css",
        "/css/bootstrap-theme.min.css",
        "/css/main.css"
      ]

      js_compression :jsmin

      js :application, [
        "/js/jquery-2.1.1.min.js",
        "/js/bootstrap.min.js"
      ]

      prebuild true
    end

    before do
      I18n.locale = ENV["LOCALE"].present? ? ENV["LOCALE"].to_sym : :en
      redirect to("/setup") if needs_setup?(request.path)
      redirect to("/login") if require_login?(request.path) && !logged_in?
    end
  end
end
