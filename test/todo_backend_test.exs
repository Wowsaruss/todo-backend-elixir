defmodule TodoBackendTest do
  use ExUnit.Case
  doctest TodoBackend

  test "greets the world" do
    assert TodoBackend.hello() == :world
  end
end
