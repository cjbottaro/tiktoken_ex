defmodule Tiktoken.MixProject do
  use Mix.Project

  # Needs to be a module var for the GHA to work, but don't put the comment on
  # the same line because the regex will mess up.
  @version "0.1.0"
  @source_url "https://github.com/cjbottaro/tiktoken_ex"

  def project do
    [
      app: :tiktoken,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @source_url,
      package: package(),
      description: "Tiktoken using precompiled Rust NIF for tiktoken-rs",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.6"},
      {:rustler, "~> 0.27", optional: true},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  defp package() do
    [
      maintainers: ["Christopher J. Bottaro"],
      licenses: ["Unlicense"],
      links: %{"GitHub" => @source_url},
      files: [
        "lib",
        "mix.exs",
        "README*",
        "native/tiktoken/*",
        "checksum-*.exs"
      ]
    ]
  end
end
