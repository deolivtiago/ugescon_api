defmodule Api.Location.State.Delete do
  @moduledoc false
  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call(%State{} = state), do: Repo.delete(state)
end
