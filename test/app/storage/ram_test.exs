defmodule App.Storage.RamTest do
  use ExUnit.Case
  alias App.Storage.Ram

  test "set and get" do
    Ram.set(:some_value)
    assert Ram.get() == :some_value
  end
end
