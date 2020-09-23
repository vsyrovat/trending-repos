defmodule App.Github do
  @moduledoc """
  Provides data directly from Github
  """

  alias App.Github.Fetcher
  alias App.Github.Parser

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
    {:ok, html} = Fetcher.fetch_trending()
    Parser.parse_trending(html)
  end
end
