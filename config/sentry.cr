shard_yml = YAML.parse({{ read_file("shard.yml") }})

Raven.configure do |config|
  config.sample_rate = 1.0
  config.async = true
  config.current_environment = LuckyEnv.environment
  config.release = shard_yml["version"].as_s?
end
