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

  def get_trending_list(:daily), do: get_trending_list(@daily_id)
  def get_trending_list(id), do: Repo.get(TrendingList, id)

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

  alias App.Main.Grepo

  @doc """
  Returns the list of grepos.

  ## Examples

      iex> list_grepos()
      [%Grepo{}, ...]

  """
  def list_grepos do
    Repo.all(Grepo)
  end

  def list_grepos_by_full_names(full_names) when is_list(full_names) do
    Repo.all(from gr in Grepo, where: gr.full_name in ^full_names)
  end

  @doc """
  Gets a single grepo.

  Raises `Ecto.NoResultsError` if the Grepo does not exist.

  ## Examples

      iex> get_grepo!(123)
      %Grepo{}

      iex> get_grepo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_grepo!(id) when is_integer(id), do: Repo.get!(Grepo, id)

  def get_grepo!(full_name) when is_binary(full_name) do
    Repo.one!(from gr in Grepo, where: gr.full_name == ^full_name, limit: 1)
  end

  def get_grepo(id) when is_integer(id), do: Repo.get(Grepo, id)

  def get_grepo(full_name) when is_binary(full_name) do
    Repo.one(from gr in Grepo, where: gr.full_name == ^full_name, limit: 1)
  end

  def get_oldest_updated_grepo(full_names) when is_list(full_names) do
    Repo.one(from gr in Grepo, where: gr.full_name in ^full_names, order_by: [asc: :updated_at], limit: 1)
  end

  def get_any_grepo do
    Repo.one(from gr in Grepo, limit: 1)
  end

  @doc """
  Creates a grepo.

  ## Examples

      iex> create_grepo(%{field: value})
      {:ok, %Grepo{}}

      iex> create_grepo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_grepo(attrs \\ %{}) do
    %Grepo{}
    |> Grepo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a grepo.

  ## Examples

      iex> update_grepo(grepo, %{field: new_value})
      {:ok, %Grepo{}}

      iex> update_grepo(grepo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_grepo(%Grepo{} = grepo, attrs) do
    grepo
    |> Grepo.changeset(attrs)
    |> Repo.update()
  end

  def create_or_update_grepo(attrs) do
    case Repo.get(Grepo, attrs.id) do
      nil -> create_grepo(attrs)
      grepo -> update_grepo(grepo, attrs)
    end
  end

  @doc """
  Deletes a grepo.

  ## Examples

      iex> delete_grepo(grepo)
      {:ok, %Grepo{}}

      iex> delete_grepo(grepo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_grepo(%Grepo{} = grepo) do
    Repo.delete(grepo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking grepo changes.

  ## Examples

      iex> change_grepo(grepo)
      %Ecto.Changeset{data: %Grepo{}}

  """
  def change_grepo(%Grepo{} = grepo, attrs \\ %{}) do
    Grepo.changeset(grepo, attrs)
  end
end
