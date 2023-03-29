defmodule Api.Accounting.Account do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Accounting.Entry

  schema "accounts" do
    field :level, :integer
    field :code, :string
    field :name, :string
    field :type, Ecto.Enum, values: [debit: 0, credit: 1]
    has_many :debit_entries, Entry, foreign_key: :debit_account_code, references: :code
    has_many :credit_entries, Entry, foreign_key: :credit_account_code, references: :code

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:code, :name, :type, :level])
    |> validate_required([:code, :name, :type, :level])
    |> unique_constraint(:id, name: :accounts_pkey)
    |> unique_constraint(:code)
    |> validate_length(:name, min: 2, max: 150)
    |> validate_length(:code, min: 1, max: 5)
    |> validate_format(:code, ~r/^[0-9]+$/, message: "must contain only numbers")
    |> validate_number(:level, greater_than: 0, less_than: 5)
  end
end
