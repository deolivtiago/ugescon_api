defmodule Api.Accounting.Entry do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Accounting.Account
  alias Api.Registry.Person

  @required_attrs [:type, :value, :debit_account_code, :credit_account_code]
  @valid_account_code_message "must be a valid account code"

  schema "entries" do
    field :description, :string
    field :type, Ecto.Enum, values: [debit: 0, credit: 1]
    field :value, :integer
    field :date, :utc_datetime

    belongs_to :debit_account, Account,
      foreign_key: :debit_account_code,
      references: :code,
      type: :string

    belongs_to :credit_account, Account,
      foreign_key: :credit_account_code,
      references: :code,
      type: :string

    belongs_to :person, Person

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, @required_attrs ++ [:description, :person_id, :date])
    |> validate_required(@required_attrs)
    |> unique_constraint(:id, name: :entries_pkey)
    |> assoc_constraint(:person)
    |> validate_length(:debit_account_code, min: 1, max: 5, message: @valid_account_code_message)
    |> validate_format(:debit_account_code, ~r/^[0-9]+$/, message: @valid_account_code_message)
    |> assoc_constraint(:debit_account)
    |> validate_length(:credit_account_code, min: 1, max: 5, message: @valid_account_code_message)
    |> validate_format(:credit_account_code, ~r/^[0-9]+$/, message: @valid_account_code_message)
    |> assoc_constraint(:credit_account)
    |> validate_length(:description, max: 255)
  end
end
