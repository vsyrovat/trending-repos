defmodule App.Github.Fetcher do
  @moduledoc """
  Fetch trending repo page (html)
  """

  use Tesla

  @trending_url "https://github.com/trending"

  @spec fetch_trending :: {:ok, String.t()} | {:error, Tesla.Env.t()}
  def fetch_trending do
    {:ok, response} = get(@trending_url)

    case response do
      %Tesla.Env{status: 200, body: body} -> {:ok, body}
      _ -> {:error, response}
    end
  end
end
