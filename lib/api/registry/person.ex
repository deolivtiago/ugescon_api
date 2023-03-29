defmodule Api.Registry.Person do
  use Api.Schema

  import Ecto.Changeset

  schema "persons" do
    field :alias, :string
    field :name, :string
    field :social_id, :string
    field :type, Ecto.Enum, values: [natural: 0, juridical: 1, other: 2]

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :alias, :social_id, :type])
    |> validate_required([:name, :type])
    |> unique_constraint(:id, name: :persons_pkey)
    |> unique_constraint(:social_id)
    |> validate_length(:alias, max: 150)
    |> validate_length(:name, min: 2, max: 150)
    |> validate_length(:social_id, max: 15)
    |> validate_format(:social_id, ~r/^[0-9]+$/, message: "must contain only numbers")
  end
end
