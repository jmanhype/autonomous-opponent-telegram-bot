defmodule AutonomousOpponent.MixProject do
  use Mix.Project

  def project do
    [
      app: :autonomous_opponent,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AutonomousOpponent.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Telegram bot dependencies
      {:ex_gram, "~> 0.52"},
      
      # HTTP client dependencies
      {:tesla, "~> 1.8"},
      {:hackney, "~> 1.20"},
      
      # JSON parsing
      {:jason, "~> 1.4"},
      
      # Development and analysis tools
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end
end
