defmodule App.GithubTest do
  use ExUnit.Case
  import Tesla.Mock
  alias App.Github
  alias App.Github.ParserTest

  test "fetch and parse trending repos" do
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

    assert Github.trending_repos() == {:ok, ParserTest.correct_repos()}
  end
end
