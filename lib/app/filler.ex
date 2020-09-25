defmodule App.Filler do
  @moduledoc """
  Fill storage with Github data
  """

  alias App.Github
  alias App.Github.RepositoryFetcher
  alias App.Main
  require Logger

  @cache_ttl 7200

  def refill do
    refill_trending_repos_if_need()
    refill_repos_if_need()
  end

  defp refill_trending_repos_if_need do
    if need_refill_trending_repos?(), do: refill_trending_repos()
  end

  defp need_refill_trending_repos? do
    case Main.get_trending_list(:daily) do
      nil -> true
      %{updated_at: updated_at} -> NaiveDateTime.add(updated_at, @cache_ttl) < NaiveDateTime.utc_now()
    end
  end

  defp refill_trending_repos do
    {:ok, repos} = Github.trending_repos()
    Main.create_or_update_trending_list(%{data: repos}, :daily)
  end

  defp refill_repos_if_need do
    trending_repos = Main.get_trending_list!(:daily).data
    trending_repos_full_names = Enum.map(trending_repos, & &1["full_name"])
    fill_next_repo(trending_repos_full_names)
  end

  defp fill_next_repo([]), do: {:ok, :done}

  defp fill_next_repo(candidates) do
    case suggest_repo_for_fill(candidates) do
      {:ok, full_name} ->
        case RepositoryFetcher.fetch(full_name) do
          {:ok, repo, _limit} ->
            Main.create_or_update_grepo(%{id: repo.id, full_name: repo.full_name, data: repo.data})
            Logger.info("Filled " <> repo.full_name)
            fill_next_repo(candidates -- [full_name])

          {:error, :limit_exceeded, limit} ->
            next_dose_in = round((DateTime.to_unix(limit.reset_at) - DateTime.to_unix(DateTime.utc_now())) / 60)
            Logger.warn("Github API limit reached, next dose in #{next_dose_in} min")
            {:ok, :limit_exceeded}

          {:error, _} ->
            fill_next_repo(candidates -- [full_name])
        end

      :none ->
        Logger.info("No need fill repos this time")
        {:ok, :done}
    end
  end

  defp suggest_repo_for_fill(candidates) do
    exists_grepos = Main.list_grepos_by_full_names(candidates)
    unexists_repos_names = candidates -- Enum.map(exists_grepos, & &1.full_name)

    case unexists_repos_names do
      [] -> suggest_oldest_updated_repo(candidates)
      [full_name | _] -> {:ok, full_name}
    end
  end

  defp suggest_oldest_updated_repo(candidates) do
    case Main.get_oldest_updated_grepo(candidates) do
      nil ->
        :none

      grepo ->
        if enough_old_to_refetch?(grepo),
          do: {:ok, grepo.full_name},
          else: :none
    end
  end

  defp enough_old_to_refetch?(grepo) do
    NaiveDateTime.add(grepo.updated_at, @cache_ttl) < NaiveDateTime.utc_now()
  end
end
