defmodule Api.Location.State.Get do
  @moduledoc false
  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call(id) do
    State
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> State.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
