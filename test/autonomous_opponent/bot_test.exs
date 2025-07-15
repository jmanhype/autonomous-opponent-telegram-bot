defmodule AutonomousOpponent.BotTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureLog
  alias AutonomousOpponent.Bot

  describe "handle/2 for commands" do
    test "handles /start command with welcome message" do
      # Create a mock context
      context = %{
        chat_id: 123456,
        update: %{
          message: %{
            chat: %{id: 123456},
            text: "/start"
          }
        }
      }

      # Capture logs to verify logging
      logs = capture_log(fn ->
        result = Bot.handle({:command, "start", %{}}, context)
        
        # Verify the bot returns a response
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.chat_id == 123456
        assert result.text =~ "Welcome to Autonomous Opponent Bot!"
        assert result.parse_mode == "Markdown"
      end)

      assert logs =~ "Received /start command from chat_id: 123456"
    end

    test "handles /help command with help message" do
      context = %{
        chat_id: 789012,
        update: %{
          message: %{
            chat: %{id: 789012},
            text: "/help"
          }
        }
      }

      logs = capture_log(fn ->
        result = Bot.handle({:command, "help", %{}}, context)
        
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.chat_id == 789012
        assert result.text =~ "Available Commands:"
        assert result.text =~ "/start"
        assert result.text =~ "/help"
        assert result.parse_mode == "Markdown"
      end)

      assert logs =~ "Received /help command from chat_id: 789012"
    end

    test "handles /challenge command" do
      context = %{
        chat_id: 345678,
        update: %{
          message: %{
            chat: %{id: 345678},
            text: "/challenge"
          }
        }
      }

      logs = capture_log(fn ->
        result = Bot.handle({:command, "challenge", %{}}, context)
        
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.chat_id == 345678
        assert result.text =~ "New Challenge!"
        assert result.text =~ "coming soon"
      end)

      assert logs =~ "Received /challenge command from chat_id: 345678"
    end

    test "handles unknown commands gracefully" do
      context = %{
        chat_id: 111111,
        update: %{
          message: %{
            chat: %{id: 111111},
            text: "/unknown"
          }
        }
      }

      logs = capture_log(fn ->
        result = Bot.handle({:command, "unknown", %{}}, context)
        
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.chat_id == 111111
        assert result.text =~ "I don't recognize the command"
        assert result.text =~ "/unknown"
        assert result.text =~ "/help"
      end)

      assert logs =~ "Received unknown command: /unknown"
    end
  end

  describe "handle/2 for text messages" do
    test "handles regular text messages" do
      context = %{
        chat_id: 222222,
        update: %{
          message: %{
            chat: %{id: 222222},
            text: "Hello bot!"
          }
        }
      }

      logs = capture_log(fn ->
        result = Bot.handle({:text, "Hello bot!", %{}}, context)
        
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.chat_id == 222222
        assert result.text =~ "I received your message"
        assert result.text =~ "Hello bot!"
      end)

      assert logs =~ "Received text message: 'Hello bot!'"
    end
  end

  describe "handle/2 for callback queries" do
    test "handles callback queries from inline keyboards" do
      query = %{
        id: "callback123",
        data: "button_pressed"
      }
      
      context = %{
        chat_id: 333333,
        update: %{
          callback_query: query
        }
      }

      logs = capture_log(fn ->
        # The bot should acknowledge the callback and send a response
        result = Bot.handle({:callback_query, query}, context)
        
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.text =~ "Button pressed: button_pressed"
      end)

      assert logs =~ "Received callback query with data: button_pressed"
    end
  end

  describe "handle/2 for unhandled updates" do
    test "silently handles unhandled update types" do
      context = %{
        update: %{
          some_unknown_field: "value"
        }
      }

      logs = capture_log(fn ->
        result = Bot.handle({:update, %{some_unknown_field: "value"}}, context)
        
        # Should return the context unchanged
        assert result == context
      end)

      assert logs =~ "Received unhandled update type"
    end
  end

  describe "handle/2 for errors" do
    test "handles errors gracefully" do
      context = %{
        chat_id: 444444,
        update: %{
          message: %{
            chat: %{id: 444444}
          }
        }
      }

      error = %RuntimeError{message: "Something went wrong"}

      logs = capture_log(fn ->
        result = Bot.handle({:error, error}, context)
        
        assert is_map(result)
        assert result.method == :sendMessage
        assert result.chat_id == 444444
        assert result.text =~ "An error occurred"
      end)

      assert logs =~ "Error occurred:"
      assert logs =~ "Something went wrong"
    end
  end
end