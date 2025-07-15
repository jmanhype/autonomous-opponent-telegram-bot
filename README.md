# Autonomous Opponent Bot

An AI-powered Telegram bot built with Elixir and ExGram framework.

## Features

- 🤖 Interactive AI challenges
- 📊 User statistics tracking
- 🏆 Leaderboard system
- 🎯 Adaptive difficulty
- 💬 Natural language processing
- 🔄 Fault-tolerant OTP architecture

## Prerequisites

- Elixir 1.18 or higher
- Erlang/OTP 24 or higher
- A Telegram Bot Token (get one from [@BotFather](https://t.me/botfather))

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd autonomous_opponent
```

2. Install dependencies:
```bash
mix deps.get
```

3. Set up your environment variables:
```bash
export TELEGRAM_BOT_TOKEN="your-bot-token-here"
```

## Development

### Running the bot locally

```bash
mix run --no-halt
```

### Running tests

```bash
mix test
```

### Code quality checks

```bash
# Format code
mix format

# Run static analysis
mix credo

# Run all quality checks
mix format && mix credo && mix test
```

## Configuration

The bot can be configured through environment-specific config files:

- `config/config.exs` - Base configuration
- `config/dev.exs` - Development environment
- `config/test.exs` - Test environment
- `config/runtime.exs` - Runtime configuration (production)

### Environment Variables

- `TELEGRAM_BOT_TOKEN` (required) - Your Telegram bot token
- `BOT_NAME` (optional) - Custom bot name (default: "AutonomousOpponent")
- `WEBHOOK_URL` (required in production) - Webhook URL for production
- `MAX_CONNECTIONS` (optional) - Maximum webhook connections (default: 100)

## Commands

The bot supports the following commands:

- `/start` - Welcome message and introduction
- `/help` - Show available commands
- `/challenge` - Start a new challenge
- `/stats` - View your statistics
- `/leaderboard` - See top players

## Architecture

The bot is built using OTP principles:

```
AutonomousOpponent.Application (Supervisor)
├── ExGram (Registry)
└── AutonomousOpponent.Bot (Worker)
```

- **Application** - Main OTP application with supervision tree
- **Bot** - Handles all Telegram interactions and commands
- **Config** - Environment-specific configuration

## Deployment

### Production Configuration

1. Set required environment variables:
```bash
export TELEGRAM_BOT_TOKEN="your-bot-token"
export WEBHOOK_URL="https://your-domain.com/webhook"
export MIX_ENV=prod
```

2. Build release:
```bash
mix release
```

3. Run the release:
```bash
_build/prod/rel/autonomous_opponent/bin/autonomous_opponent start
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with [ExGram](https://github.com/rockneurotiko/ex_gram)
- Powered by [Telegram Bot API](https://core.telegram.org/bots/api)

