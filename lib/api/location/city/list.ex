defmodule Api.Location.City.List do
  @moduledoc false
  import Ecto.Query, only: [from: 2]

  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call, do: Repo.all(City)

  def call(state_id: state_id) do
    query =
      from c in City,
        where: c.state_id == ^state_id

    Repo.all(query)
  end
end
