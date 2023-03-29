defmodule Api.Location.City.List do
  @moduledoc false
  import Ecto.Query, only: [from: 2]

  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call do
    City
    |> Repo.all()
    |> Repo.preload(state: :country)
  end

  def call(state_id: state_id) do
    query =
      from c in City,
        where: c.state_id == ^state_id

    query
    |> Repo.all()
    |> Repo.preload(state: :country)
  end
end
