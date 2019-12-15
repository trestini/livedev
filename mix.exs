defmodule Livedev.MixProject do
  use Mix.Project

  def project do
    [
      app: :livedev,
      version: "0.0.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Livedev",
      source_url: "https://github.com/trestini/livedev"
    ]
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"}
    ]
  end

  defp description() do
    "Automatically recompile a mix project on file changes when running in interactive mode with IEx"
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/trestini/livedev"}
    ]
  end
end
