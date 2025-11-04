defmodule AutonomousOpponent.Application do
  @moduledoc """
  The main OTP Application for Autonomous Opponent bot.
  
  This module starts the supervision tree which includes:
  - ExGram registry for managing bot processes
  - The main bot worker process
  """

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info("Starting Autonomous Opponent application...")

    # Validate bot token is present before starting
    bot_token = System.get_env("TELEGRAM_BOT_TOKEN")

    unless bot_token do
      Logger.error("TELEGRAM_BOT_TOKEN environment variable is not set!")
      raise """
      Missing required environment variable: TELEGRAM_BOT_TOKEN

      Please set your Telegram bot token:
        export TELEGRAM_BOT_TOKEN="your-bot-token-here"

      You can get a bot token by talking to @BotFather on Telegram.
      """
    end

    bot_config = [
      method: :polling,
      token: bot_token
    ]

    children = [
      # ExGram registry must start before the bot
      ExGram,
      # The main bot worker with required configuration
      {AutonomousOpponent.Bot, bot_config}
    ]

    # Using :one_for_one strategy for fault tolerance
    # If a child process crashes, only that process is restarted
    opts = [
      strategy: :one_for_one, 
      name: AutonomousOpponent.Supervisor,
      max_restarts: 3,
      max_seconds: 5
    ]
    
    case Supervisor.start_link(children, opts) do
      {:ok, pid} ->
        Logger.info("Autonomous Opponent application started successfully")
        {:ok, pid}
      {:error, reason} ->
        Logger.error("Failed to start Autonomous Opponent application: #{inspect(reason)}")
        {:error, reason}
    end
  end

  @impl true
  def stop(_state) do
    Logger.info("Stopping Autonomous Opponent application...")
    :ok
  end
end
