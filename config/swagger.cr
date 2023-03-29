LuckySwagger.configure do |settings|
  settings.app_name = "Paste69"
  settings.version = ENV["APP_VERSION"]
  settings.uri = "/api/v1"
  settings.description = "Paste69 pastebin service API"
  settings.terms_url = "https://0x45.st/terms"
end
