defmodule Api.Location.State do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Location.Country

  schema "states" do
    field :code, :string
    field :name, :string
    belongs_to :country, Country

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:name, :code, :country_id])
    |> validate_required([:name, :code])
    |> unique_constraint(:id, name: :states_pkey)
    |> assoc_constraint(:country)
    |> validate_length(:code, is: 2)
    |> update_change(:code, &String.upcase/1)
    |> validate_format(:code, ~r/^[A-Z]+$/, message: "must contain only characters A-Z")
    |> validate_length(:name, min: 2, max: 150)
  end
end
