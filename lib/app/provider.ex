defmodule App.Provider do
  @moduledoc """
  Provide data for other Elixir modules
  """

  alias App.Github.Repo
  alias App.Storage

  @spec trending_repos() :: {:ok, list(Repo.t())} | {:error, :unfilled | :unrecognized}
  def trending_repos do
    case Storage.get() do
      {:repos, repos} -> {:ok, repos}
      nil -> {:error, :unfilled}
      _ -> {:error, :unrecognized}
    end
  end
end
