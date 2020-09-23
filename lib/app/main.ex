defmodule App.Main do
  @moduledoc """
  The Main context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Main.TrendingList

  @daily_id 1

  @doc """
  Returns the list of trending_lists.

  ## Examples

      iex> list_trending_lists()
      [%TrendingList{}, ...]

  """
  def list_trending_lists do
    Repo.all(TrendingList)
  end

  @doc """
  Gets a single trending_list.

  Raises `Ecto.NoResultsError` if the Trending list does not exist.

  ## Examples

      iex> get_trending_list!(123)
      %TrendingList{}

      iex> get_trending_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trending_list!(:daily), do: get_trending_list!(@daily_id)
  def get_trending_list!(id), do: Repo.get!(TrendingList, id)

  @doc """
  Creates a trending_list.

  ## Examples

      iex> create_trending_list(%{field: value})
      {:ok, %TrendingList{}}

      iex> create_trending_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trending_list(attrs \\ %{}) do
    %TrendingList{}
    |> TrendingList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trending_list.

  ## Examples

      iex> update_trending_list(trending_list, %{field: new_value})
      {:ok, %TrendingList{}}

      iex> update_trending_list(trending_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trending_list(%TrendingList{} = trending_list, attrs) do
    trending_list
    |> TrendingList.changeset(attrs)
    |> Repo.update()
  end

  def create_or_update_trending_list(attrs, :daily) do
    case Repo.get(TrendingList, @daily_id) do
      nil -> create_trending_list(Map.put(attrs, :id, @daily_id))
      trending_list -> update_trending_list(trending_list, attrs)
    end
  end

  @doc """
  Deletes a trending_list.

  ## Examples

      iex> delete_trending_list(trending_list)
      {:ok, %TrendingList{}}

      iex> delete_trending_list(trending_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trending_list(%TrendingList{} = trending_list) do
    Repo.delete(trending_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trending_list changes.

  ## Examples

      iex> change_trending_list(trending_list)
      %Ecto.Changeset{data: %TrendingList{}}

  """
  def change_trending_list(%TrendingList{} = trending_list, attrs \\ %{}) do
    TrendingList.changeset(trending_list, attrs)
  end
end
