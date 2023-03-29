defmodule Api.Registry.Person do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Accounting.Entry
  alias Api.Registry.Address
  alias Api.UserManagement.User

  schema "persons" do
    field :alias, :string
    field :name, :string
    field :social_id, :string
    field :type, Ecto.Enum, values: [natural: 0, juridical: 1, other: 2]
    belongs_to :user, User
    has_many :entries, Entry
    has_one :address, Address, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :alias, :social_id, :type, :user_id])
    |> validate_required([:name, :type, :user_id])
    |> unique_constraint(:id, name: :persons_pkey)
    |> assoc_constraint(:user)
    |> cast_assoc(:entries)
    |> cast_assoc(:address)
    |> unique_constraint(:social_id)
    |> validate_length(:alias, max: 150)
    |> validate_length(:name, min: 2, max: 150)
    |> validate_length(:social_id, max: 15)
    |> validate_format(:social_id, ~r/^[0-9]+$/, message: "must contain only numbers")
  end
end
