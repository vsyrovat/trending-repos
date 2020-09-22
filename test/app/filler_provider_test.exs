defmodule App.FillerProviderTest do
  use ExUnit.Case
  import Tesla.Mock
  alias App.Filler
  alias App.Github.ParserTest
  alias App.Provider

  test "refill and get trending repos" do
    mock(fn
      %{
        method: :get,
        url: "https://github.com/trending"
      } ->
        %Tesla.Env{
          status: 200,
          body: ParserTest.trending_html()
        }
    end)

    Filler.refill_trending_repos()
    assert Provider.trending_repos() == {:ok, ParserTest.correct_repos()}
  end
end
