defmodule AutonomousOpponent.Bot do
  @moduledoc """
  Main bot module for Autonomous Opponent.
  
  This module implements the ExGram.Bot behaviour and handles
  all incoming messages and commands from Telegram users.
  """

  @bot_name Application.compile_env(:ex_gram, :bot, :AutonomousOpponent)
  
  use ExGram.Bot, name: @bot_name
  require Logger

  @doc """
  Handle the /start command.
  
  Sends a welcome message to new users.
  """
  def handle({:command, "start", _msg}, context) do
    chat_id = get_chat_id(context)
    Logger.info("Received /start command from chat_id: #{chat_id}")
    
    welcome_message = """
    🤖 Welcome to Autonomous Opponent Bot!
    
    I'm your AI-powered opponent ready to challenge you.
    
    Available commands:
    /start - Show this welcome message
    /help - Show available commands
    /challenge - Start a new challenge
    
    Let's begin! 🚀
    """
    
    answer(context, welcome_message, parse_mode: "Markdown")
  end

  @doc """
  Handle the /help command.
  
  Shows available commands and usage information.
  """
  def handle({:command, "help", _msg}, context) do
    chat_id = get_chat_id(context)
    Logger.info("Received /help command from chat_id: #{chat_id}")
    
    help_message = """
    📋 *Available Commands:*
    
    /start - Start the bot and see welcome message
    /help - Show this help message
    /challenge - Start a new challenge
    /stats - View your statistics
    /leaderboard - See the top players
    
    💡 *Tips:*
    - Use inline keyboards for quick responses
    - Your progress is automatically saved
    - Challenges adapt to your skill level
    """
    
    answer(context, help_message, parse_mode: "Markdown")
  end

  @doc """
  Handle the /challenge command.
  
  Starts a new challenge for the user.
  """
  def handle({:command, "challenge", _msg}, context) do
    chat_id = get_chat_id(context)
    Logger.info("Received /challenge command from chat_id: #{chat_id}")
    
    # TODO: Implement challenge logic
    challenge_message = """
    🎯 *New Challenge!*
    
    Feature coming soon! Stay tuned for exciting challenges.
    """
    
    answer(context, challenge_message, parse_mode: "Markdown")
  end

  @doc """
  Handle unknown commands.
  
  Provides a helpful response for unrecognized commands.
  """
  def handle({:command, unknown_cmd, _msg}, context) do
    chat_id = get_chat_id(context)
    Logger.warning("Received unknown command: /#{unknown_cmd} from chat_id: #{chat_id}")
    
    error_message = """
    ❓ Sorry, I don't recognize the command `/#{unknown_cmd}`.
    
    Use /help to see available commands.
    """
    
    answer(context, error_message, parse_mode: "Markdown")
  end

  @doc """
  Handle regular text messages.
  
  Processes non-command text messages from users.
  """
  def handle({:text, text, _msg}, context) do
    chat_id = get_chat_id(context)
    Logger.debug("Received text message: '#{text}' from chat_id: #{chat_id}")
    
    # TODO: Implement natural language processing
    response = """
    I received your message: "#{text}"
    
    Use /help to see what I can do!
    """
    
    answer(context, response)
  end

  @doc """
  Handle callback queries from inline keyboards.
  
  Processes button presses from inline keyboards.
  """
  def handle({:callback_query, %{data: data} = query}, context) do
    Logger.info("Received callback query with data: #{data}")
    
    # Acknowledge the callback query to remove loading state
    ExGram.answer_callback_query(query.id, text: "Processing...")
    
    # TODO: Implement callback handling logic based on data
    answer(context, "Button pressed: #{data}")
  end

  @doc """
  Fallback handler for all other update types.
  
  This ensures we gracefully handle any update type we haven't
  specifically implemented.
  """
  def handle({:update, update}, context) do
    Logger.debug("Received unhandled update type: #{inspect(update)}")
    
    # Silently ignore unhandled update types
    # This prevents the bot from crashing on unexpected inputs
    context
  end

  @doc """
  Handle errors that occur during message processing.
  
  This ensures the bot continues running even if errors occur.
  """
  def handle({:error, error}, context) do
    Logger.error("Error occurred: #{inspect(error)}")
    
    # Optionally notify the user about the error
    answer(context, "⚠️ An error occurred. Please try again later.")
  end

  # Helper function to extract chat_id from context
  defp get_chat_id(context) do
    case context do
      %{chat: %{id: id}} -> id
      %{message: %{chat: %{id: id}}} -> id
      %{update: %{message: %{chat: %{id: id}}}} -> id
      _ -> nil
    end
  end
end