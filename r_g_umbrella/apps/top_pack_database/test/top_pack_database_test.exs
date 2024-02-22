defmodule TopPackDatabaseTest do
  use ExUnit.Case
  doctest TopPackDatabase

  test "greets the world" do
    assert TopPackDatabase.hello() == :world
  end
end
