defmodule App.Repo.Migrations.CreateGreposos do
  use Ecto.Migration

  def change do
    create table(:grepos) do
      add :full_name, :string
      add :data, :map

      timestamps()
    end

    create unique_index(:grepos, [:full_name])
  end
end
