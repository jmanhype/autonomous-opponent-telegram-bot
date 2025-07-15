defmodule AutonomousOpponent do
  @moduledoc """
  Autonomous Opponent - An AI-powered Telegram bot for interactive challenges.
  
  This is the main entry point module for the Autonomous Opponent bot.
  The bot provides various commands and features for users to interact with
  AI-powered challenges and games.
  
  ## Features
  
  - Interactive challenges
  - User statistics tracking
  - Leaderboard system
  - Adaptive difficulty
  
  ## Usage
  
  The bot runs as an OTP application. To start it:
  
      mix run --no-halt
  
  Or in production:
  
      MIX_ENV=prod mix run --no-halt
  
  ## Configuration
  
  The bot requires a Telegram bot token which should be set in the
  `TELEGRAM_BOT_TOKEN` environment variable.
  
  See `config/runtime.exs` for all configuration options.
  """

  @doc """
  Returns the current version of the Autonomous Opponent bot.
  
  ## Examples
  
      iex> AutonomousOpponent.version()
      "0.1.0"
  
  """
  @spec version() :: String.t()
  def version do
    Application.spec(:autonomous_opponent, :vsn) |> to_string()
  end

  @doc """
  Returns the bot's current status.
  
  ## Examples
  
      iex> AutonomousOpponent.status()
      %{
        bot_name: "AutonomousOpponent",
        running: true,
        environment: :dev,
        version: "0.1.0"
      }
  
  """
  @spec status() :: map()
  def status do
    %{
      bot_name: Application.get_env(:ex_gram, :bot, "AutonomousOpponent"),
      running: bot_running?(),
      environment: Application.get_env(:autonomous_opponent, :environment, :dev),
      version: version()
    }
  end

  @doc """
  Checks if the bot is currently running.
  
  ## Examples
  
      iex> AutonomousOpponent.bot_running?()
      true
  
  """
  @spec bot_running?() :: boolean()
  def bot_running? do
    case Process.whereis(AutonomousOpponent.Bot) do
      nil -> false
      pid -> Process.alive?(pid)
    end
  end

  @doc """
  Returns configuration information for the bot.
  
  ## Examples
  
      iex> AutonomousOpponent.config()
      %{
        adapter: ExGram.Adapter.Tesla,
        method: :polling,
        environment: :dev
      }
  
  """
  @spec config() :: map()
  def config do
    %{
      adapter: Application.get_env(:ex_gram, :adapter),
      method: Application.get_env(:ex_gram, :method, :polling),
      environment: Application.get_env(:autonomous_opponent, :environment, :dev),
      debug_mode: Application.get_env(:autonomous_opponent, :debug_mode, false)
    }
  end
end
