# Livedev

Automatically recompile a mix project on file changes when running in interactive mode with IEx.

## Pre requisites

IEx Livedev uses [Watchman](https://facebook.github.io/watchman/) as a file watching service.

#### Watchman install on MacOS via Homebrew

```
brew update
brew install watchman
```

#### Watchman binary downloads for Linux, Windows and MacOS without homebrew

1. Go to [recent CI builds](https://github.com/facebook/watchman/actions?query=is%3Asuccess+event%3Apush+branch%3Amaster)
1. Click on the last CI build
1. Choose your platform on the left sidebar
1. Download the binary on "Artifacts" dropdown on the top right

Please refer to [instalation](https://facebook.github.io/watchman/docs/install.html) for detailed instructions.

## Installation

The package can be installed by adding `livedev` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:livedev, github: "trestini/livedev"}
  ]
end
```

> Note: The updated hex package will only be provided after initial alpha stage (version 0.1.0+)

## Usage

Start the Mix project in IEx with:

```
iex -S mix
```

Start Livedev watching with:

```
Livedev.start
```
