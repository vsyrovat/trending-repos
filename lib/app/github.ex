defmodule App.Github do
  @moduledoc """
  Provides data directly from Github
  """

  alias App.Github.TrendingFetcher
  alias App.Github.TrendingParser

  use TypedStruct

  defmodule Repo do
    @moduledoc false
    @derive Jason.Encoder
    typedstruct enforce: true do
      field :full_name, String.t()
      field :stars_today, integer()
    end
  end

  def trending_repos do
    {:ok, html} = TrendingFetcher.fetch_trending()
    TrendingParser.parse_trending(html)
  end
end
