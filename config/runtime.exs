import Config

# Runtime configuration for production environment
# This file is evaluated at runtime

if config_env() == :prod do
  # Configure bot token from environment variable
  bot_token = 
    System.get_env("TELEGRAM_BOT_TOKEN") ||
    raise """
    Environment variable TELEGRAM_BOT_TOKEN is missing.
    You can generate a bot token by talking to @BotFather on Telegram.
    """

  config :ex_gram,
    token: bot_token,
    # Use webhook in production for better performance
    method: :webhook,
    webhook: [
      url: System.get_env("WEBHOOK_URL") || raise("WEBHOOK_URL is required in production"),
      max_connections: System.get_env("MAX_CONNECTIONS", "100") |> String.to_integer(),
      allowed_updates: ["message", "callback_query", "inline_query"]
    ]

  # Configure logger for production
  config :logger,
    level: :info,
    metadata: [:bot_name, :chat_id, :user_id]

  # Production-specific settings
  config :autonomous_opponent,
    environment: :prod,
    debug_mode: false
end

# Configure bot name from environment (for all environments)
config :ex_gram,
  bot: System.get_env("BOT_NAME", "AutonomousOpponent")