defmodule App.ProviderTest do
  use ExUnit.Case
  alias App.Provider
  alias App.Storage

  test "getting repos returns ok" do
    Storage.set({:repos, :value})
    assert Provider.trending_repos() == {:ok, :value}
  end

  test "getting unset data returns error" do
    Storage.set(nil)
    assert Provider.trending_repos() == {:error, :unfilled}
  end

  test "getting unknown data returns error" do
    Storage.set("unknown data")
    assert Provider.trending_repos() == {:error, :unrecognized}
  end
end
