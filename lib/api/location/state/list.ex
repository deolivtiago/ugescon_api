defmodule Api.Location.State.List do
  @moduledoc false
  import Ecto.Query, only: [from: 2]

  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call do
    State
    |> Repo.all()
    |> Repo.preload(:country)
  end

  def call(country_id: country_id) do
    query =
      from s in State,
        where: s.country_id == ^country_id

    query
    |> Repo.all()
    |> Repo.preload(:country)
  end
end
