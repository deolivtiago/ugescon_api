defmodule Api.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string, size: 150, null: false
      add :state_id, references(:states, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:cities, [:state_id])
  end
end
