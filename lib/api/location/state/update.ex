defmodule Api.Location.State.Update do
  @moduledoc false
  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call(%State{} = state, attrs) do
    state
    |> State.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, state} -> {:ok, Repo.preload(state, :country)}
      error -> error
    end
  end
end
