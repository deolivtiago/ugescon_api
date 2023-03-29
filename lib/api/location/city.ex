defmodule Api.Location.City do
  use Api.Schema

  import Ecto.Changeset

  alias Api.Location.State

  schema "cities" do
    field :name, :string
    belongs_to :state, State

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :state_id])
    |> validate_required([:name])
    |> unique_constraint(:id, name: :cities_pkey)
    |> assoc_constraint(:state)
    |> validate_length(:name, min: 2, max: 150)
  end
end
