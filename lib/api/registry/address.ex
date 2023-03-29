defmodule Api.Registry.Address do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Location.City
  alias Api.Registry.Person

  @required [:alias, :street, :zip, :city_id]
  @optional [:id, :number, :complement, :neighborhood, :person_id]

  schema "addresses" do
    field :alias, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :string
    field :street, :string
    field :zip, :string
    belongs_to :person, Person
    belongs_to :city, City

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> unique_constraint(:id, name: :addresses_pkey)
    |> assoc_constraint(:city)
    |> assoc_constraint(:person)
    |> validate_length(:alias, max: 15)
    |> validate_length(:street, min: 2, max: 150)
    |> validate_length(:number, max: 15)
    |> validate_length(:complement, max: 100)
    |> validate_length(:neighborhood, max: 100)
    |> update_change(:zip, &String.replace(&1, ~r/[^0-9]/, ""))
    |> validate_length(:zip, min: 2, max: 10)
    |> validate_format(:zip, ~r/^[0-9]+$/, message: "must contain only numbers")
  end
end
