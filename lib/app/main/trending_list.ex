defmodule App.Main.TrendingList do
  @moduledoc """
  Entity representing query result for trending repos from Github
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "trending_lists" do
    field :data, {:array, :map}

    timestamps()
  end

  @doc false
  def changeset(trending_list, attrs) do
    trending_list
    |> cast(attrs, [:id, :data])
    |> validate_required([:id, :data])
  end
end
