defmodule App.Main.Grepo do
  @moduledoc """
  Entity representing Github repository
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "grepos" do
    field :data, :map
    field :full_name, :string

    timestamps()
  end

  @doc false
  def changeset(grepo, attrs) do
    grepo
    |> cast(attrs, [:id, :full_name, :data])
    |> validate_required([:id, :full_name, :data])
    |> unique_constraint(:full_name)
  end
end
