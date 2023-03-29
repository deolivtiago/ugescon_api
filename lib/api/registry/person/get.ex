defmodule Api.Registry.Person.Get do
  @moduledoc false
  alias Api.Registry.Person
  alias Api.Repo

  @doc false
  def call(id) do
    Person
    |> Repo.get!(id)
    |> Repo.preload(address: [city: [state: :country]])
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> Person.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
