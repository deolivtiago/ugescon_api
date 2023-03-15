defmodule Api.Location.State.List do
  @moduledoc false
  import Ecto.Query, only: [from: 2]

  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call, do: Repo.all(State)

  def call(country_id: country_id) do
    query =
      from s in State,
        where: s.country_id == ^country_id

    Repo.all(query)
  end
end
