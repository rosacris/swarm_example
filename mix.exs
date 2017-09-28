defmodule MyApp.Mixfile do
  use Mix.Project

  def project do
    [
      app: :swarm_example,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MyApp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 2.2"},
      {:swarm, "~> 3.0"}
    ]
  end
end
