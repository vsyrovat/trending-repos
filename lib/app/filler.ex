defmodule App.Filler do
  @moduledoc """
  Fill storage with Github data
  """

  alias App.Github
  alias App.Storage

  def refill_trending_repos do
    {:ok, repos} = Github.trending_repos()
    Storage.set({:repos, repos})
  end
end
