import Config

# Test configuration with minimal logging
config :logger, level: :warning

# Configure ExGram for testing
config :ex_gram,
  # Use test adapter to avoid external API calls
  adapter: ExGram.Adapter.Test

# Test-specific settings
config :autonomous_opponent,
  environment: :test,
  debug_mode: false

# Ensure tests run synchronously
config :ex_unit, 
  capture_log: true