defmodule App.Github.FetcherTest do
  use ExUnit.Case
  import Tesla.Mock
  alias App.Github.Fetcher

  test "fetch trending" do
    mock(fn
      %{
        method: :get,
        url: "https://github.com/trending"
      } ->
        %Tesla.Env{status: 200, body: "Hello"}
    end)

    assert Fetcher.fetch_trending() == {:ok, "Hello"}
  end

  test "error fetching trending" do
    response = %Tesla.Env{status: 500}
    mock(fn %{method: :get, url: _} -> response end)

    assert Fetcher.fetch_trending() == {:error, response}
  end
end
