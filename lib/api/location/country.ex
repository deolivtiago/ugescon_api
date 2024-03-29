defmodule Api.Location.Country do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Location.State

  schema "countries" do
    field :code, :string
    field :name, :string
    has_many :states, State

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
    |> unique_constraint(:code)
    |> unique_constraint(:id, name: :countries_pkey)
    |> cast_assoc(:states)
    |> validate_length(:code, is: 2)
    |> update_change(:code, &String.upcase/1)
    |> validate_format(:code, ~r/^[A-Z]+$/, message: "must contain only characters A-Z")
    |> validate_length(:name, min: 2, max: 150)
  end
end
