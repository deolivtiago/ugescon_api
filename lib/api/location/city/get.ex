defmodule Api.Location.City.Get do
  @moduledoc false
  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call(id) do
    City
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> City.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
