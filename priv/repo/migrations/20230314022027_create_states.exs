defmodule Api.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :code, :string, size: 5, null: false
      add :name, :string, size: 150, null: false

      timestamps()
    end
  end
end
