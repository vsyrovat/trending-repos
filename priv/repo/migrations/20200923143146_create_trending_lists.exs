defmodule App.Repo.Migrations.CreateTrendingLists do
  use Ecto.Migration

  def change do
    create table(:trending_lists) do
      add :data, :map

      timestamps()
    end
  end
end
