defmodule Api.Registry.Address.Get do
  @moduledoc false
  alias Api.Registry.Address
  alias Api.Repo

  @doc false
  def call(id) do
    Address
    |> Repo.get!(id)
    |> Repo.preload(city: [state: :country])
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> Address.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
