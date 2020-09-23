defmodule App.Filler do
  @moduledoc """
  Fill storage with Github data
  """

  alias App.Github
  alias App.Main
  require Logger

  def refill_trending_repos do
    {:ok, repos} = Github.trending_repos()
    Main.create_or_update_trending_list(%{data: repos}, :daily)
  end
end
