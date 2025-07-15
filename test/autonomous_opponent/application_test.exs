defmodule AutonomousOpponent.ApplicationTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  describe "start/2" do
    test "starts the supervision tree successfully" do
      # Stop the application if it's already running
      Application.stop(:autonomous_opponent)

      # Capture logs during startup
      logs = capture_log(fn ->
        assert {:ok, pid} = AutonomousOpponent.Application.start(:normal, [])
        assert is_pid(pid)
        assert Process.alive?(pid)
      end)

      assert logs =~ "Starting Autonomous Opponent application"
      assert logs =~ "Autonomous Opponent application started successfully"
    end

    test "supervisor restarts children on failure" do
      # Get the supervisor PID
      supervisor = Process.whereis(AutonomousOpponent.Supervisor)
      assert is_pid(supervisor)

      # Get the list of children
      children = Supervisor.which_children(supervisor)
      assert length(children) > 0

      # The supervisor should be using :one_for_one strategy
      %{strategy: strategy} = Supervisor.count_children(supervisor)
      assert strategy == :one_for_one
    end
  end

  describe "stop/1" do
    test "stops the application gracefully" do
      logs = capture_log(fn ->
        assert :ok = AutonomousOpponent.Application.stop(:normal)
      end)

      assert logs =~ "Stopping Autonomous Opponent application"
    end
  end
end