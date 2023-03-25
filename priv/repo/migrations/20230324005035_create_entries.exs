defmodule Api.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :type, :integer, null: false
      add :date, :timestamptz, null: false, default: fragment("now()")
      add :value, :integer, null: false
      add :description, :string

      add :person_id, references(:persons, on_delete: :delete_all), null: false

      add :debit_account_code,
          references(:accounts, type: :string, column: :code, on_delete: :restrict),
          null: false

      add :credit_account_code,
          references(:accounts, type: :string, column: :code, on_delete: :restrict),
          null: false

      timestamps()
    end

    create index(:entries, [:debit_account_code])
    create index(:entries, [:credit_account_code])
    create index(:entries, [:person_id])
  end
end
