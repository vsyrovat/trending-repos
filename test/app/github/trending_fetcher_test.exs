defmodule App.Github.TrendingFetcherTest do
  use ExUnit.Case
  import Tesla.Mock
  alias App.Github.TrendingFetcher

  test "fetch trending" do
    mock(fn
      %{
        method: :get,
        url: "https://github.com/trending"
      } ->
        %Tesla.Env{status: 200, body: "Hello"}
    end)

    assert TrendingFetcher.fetch_trending() == {:ok, "Hello"}
  end

  @tag capture_log: true
  test "error fetching trending" do
    response = %Tesla.Env{status: 500}
    mock(fn %{method: :get, url: _} -> response end)

    assert TrendingFetcher.fetch_trending() == {:error, response}
  end
end
