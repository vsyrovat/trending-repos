defmodule App.Provider do
  @moduledoc """
  Provide data for other Elixir modules
  """

  alias App.Github.Repo
  alias App.Main

  @spec trending_repos() :: {:ok, list(Repo.t())} | {:error, :unfilled | :unrecognized}
  def trending_repos do
    trending_list = Main.get_trending_list!(:daily)
    {:ok, trending_list.data}
  end
end
