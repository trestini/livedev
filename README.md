# IEx Livedev

Automatically recompile a mix project on file changes when running in interactive mode with IEx.

## Pre requisites

IEx Livedev uses [Watchman](https://facebook.github.io/watchman/) as a file watching service. Please refer to [instalation instructions](https://facebook.github.io/watchman/docs/install.html) in Watchman's documentation for your platform. For the impatient: 

### MacOS via Homebrew

```
brew update
brew install watchman
```

### Linux, Windows and MacOS without homebrew

1. Go to [recent CI builds](https://github.com/facebook/watchman/actions?query=is%3Asuccess+event%3Apush+branch%3Amaster)
1. Click on the last CI build
1. Choose your platform on the left sidebar
1. Download the binary on "Artifacts" dropdown on the top right

## Installation

The package can be installed by adding `iex_livedev` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:iex_livedev, "~> 0.0.1"}
  ]
end
```

## Usage

Start the Mix project in IEx with:

```
iex -S mix
```

Start Livedev watching with:

```
Livedev.start
```

## Documentation

The docs can be found at [https://hexdocs.pm/iex_livedev](https://hexdocs.pm/iex_livedev).
