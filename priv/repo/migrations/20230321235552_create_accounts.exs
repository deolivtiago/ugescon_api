defmodule Api.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :code, :string, null: false
      add :name, :string, null: false
      add :type, :integer, null: false
      add :level, :integer, null: false

      timestamps()
    end

    create unique_index(:accounts, [:code])
  end
end
