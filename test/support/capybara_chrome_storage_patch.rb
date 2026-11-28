# Capybara 3.40.0 resets Chrome sessions with
#   Storage.clearDataForOrigin(origin: "*", ...)
# Newer Chrome versions reject "*" ("invalid argument: * is not a valid URL"),
# which makes every system test error during teardown.
#
# Replace the wildcard call with a browser-wide cookie clear, plus clearing the
# remaining storage types for the app server's actual origin.
#
# Remove once Capybara ships a fix.
module CapybaraChromeStoragePatch
  private

  def execute_cdp(cmd, params = {})
    return super unless cmd == "Storage.clearDataForOrigin" && params[:origin] == "*"

    super("Network.clearBrowserCookies")

    other_types = params[:storageTypes].to_s.split(",") - ["cookies"]
    origin = Capybara.app_host || Capybara.current_session.server&.base_url
    return if other_types.empty? || origin.nil?

    super("Storage.clearDataForOrigin", origin: origin, storageTypes: other_types.join(","))
  end
end

Capybara::Selenium::Driver::ChromeDriver.prepend(CapybaraChromeStoragePatch)
