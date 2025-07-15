import Config

# Development configuration with verbose logging
config :logger, :console,
  level: :debug,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :bot_name, :chat_id]

# Configure ExGram for development
config :ex_gram,
  # Using polling method for development
  method: :polling,
  # Poll for updates every 1 second
  polling: [
    allowed_updates: ["message", "callback_query", "inline_query"],
    limit: 100,
    offset: -1,
    timeout: 30
  ]

# Development-specific settings
config :autonomous_opponent,
  environment: :dev,
  debug_mode: true