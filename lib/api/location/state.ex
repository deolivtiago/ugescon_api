defmodule Api.Location.State do
  use Api.Schema

  import Ecto.Changeset

  schema "states" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
    |> unique_constraint(:id, name: :states_pkey)
    |> validate_length(:code, is: 2)
    |> update_change(:code, &String.upcase/1)
    |> validate_format(:code, ~r/^[A-Z]+$/, message: "must contain only characters A-Z")
    |> validate_length(:name, min: 2, max: 150)
  end
end
