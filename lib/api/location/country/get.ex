defmodule Api.Location.Country.Get do
  @moduledoc false
  alias Api.Location.Country
  alias Api.Repo

  @doc false
  def call(id) do
    Country
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> Country.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
