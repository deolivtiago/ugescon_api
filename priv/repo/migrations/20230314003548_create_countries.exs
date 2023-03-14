defmodule Api.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :code, :string, size: 5, null: false
      add :name, :string, size: 150, null: false

      timestamps()
    end

    create unique_index(:countries, [:code])
  end
end
