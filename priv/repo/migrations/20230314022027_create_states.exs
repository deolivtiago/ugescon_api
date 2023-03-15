defmodule Api.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :code, :string, size: 5, null: false
      add :name, :string, size: 150, null: false
      add :country_id, references(:countries, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:states, [:country_id])
  end
end
