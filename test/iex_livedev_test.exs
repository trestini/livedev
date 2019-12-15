defmodule IexLivedevTest do
  use ExUnit.Case
  doctest IexLivedev

  test "greets the world" do
    assert IexLivedev.hello() == :world
  end
end
