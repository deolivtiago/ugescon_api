defmodule Api.Registry.Address.List do
  @moduledoc false
  import Ecto.Query, only: [from: 2]

  alias Api.Registry.Address
  alias Api.Repo

  @doc false
  def call do
    Address
    |> Repo.all()
    |> Repo.preload(city: [state: :country])
  end

  def call(person_id: person_id) do
    query =
      from e in Address,
        where: e.person_id == ^person_id

    query
    |> Repo.all()
    |> Repo.preload(city: [state: :country])
  end
end
