defmodule Api.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :alias, :string, size: 15, null: false
      add :street, :string, size: 150, null: false
      add :number, :string, size: 15
      add :complement, :string, size: 100
      add :neighborhood, :string, size: 100
      add :zip, :string, size: 10, null: false
      add :person_id, references(:persons, on_delete: :delete_all), null: false
      add :city_id, references(:cities, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:addresses, [:person_id])
    create index(:addresses, [:city_id])
  end
end
