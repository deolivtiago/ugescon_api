defmodule Api.Location.State.Update do
  @moduledoc false
  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call(%State{} = state, attrs) do
    state
    |> State.changeset(attrs)
    |> Repo.update()
  end
end
