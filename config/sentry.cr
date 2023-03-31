shard_yml = YAML.parse({{ read_file("shard.yml") }})

Raven.configure do |config|
  config.dsn = ENV["SENTRY_DSN"]? || ""
  config.async = true
  config.current_environment = LuckyEnv.name
  config.excluded_exceptions = [] of Exception.class | String
  config.release = shard_yml["version"].as_s?
end
