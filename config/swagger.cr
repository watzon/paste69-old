LuckySwagger.configure do |settings|
  settings.title = "Paste69 API"
  settings.version = ENV["APP_VERSION"]
  settings.path = "/api/v1"
  settings.description = "Super simple API for pasting and fetching"
  settings.terms_url = "https://0x45.st/terms"
  settings.debug_mode = ENV["LUCKY_ENV"] == "development"
end
