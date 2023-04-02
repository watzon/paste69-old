require "raven"
require "./config/sentry"

begin
  raise "testing"
rescue ex
  Raven.capture(ex)
end
