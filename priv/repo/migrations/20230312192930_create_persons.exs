defmodule Api.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :alias, :string, size: 150
      add :name, :string, size: 150, null: false
      add :social_id, :string, size: 15
      add :type, :integer, null: false, default: 1
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:persons, [:social_id])
    create index(:persons, [:user_id])
  end
end
