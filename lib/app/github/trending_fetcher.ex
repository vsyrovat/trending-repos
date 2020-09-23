defmodule App.Github.TrendingFetcher do
  @moduledoc """
  Fetch trending repo page (html)
  """

  use Tesla
  require Logger

  @trending_url "https://github.com/trending"

  @spec fetch_trending :: {:ok, String.t()} | {:error, Tesla.Env.t()}
  def fetch_trending do
    {:ok, response} = get(@trending_url)

    case response do
      %Tesla.Env{status: 200, body: body} ->
        Logger.info("Trending repos fetched from Github")
        {:ok, body}

      _ ->
        Logger.warn("Error fetching trending repos from Github")
        {:error, response}
    end
  end
end
