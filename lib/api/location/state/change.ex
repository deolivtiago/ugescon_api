defmodule Api.Location.State.Change do
  @moduledoc false
  alias Api.Location.State

  @doc false
  def call(%State{} = state, attrs \\ %{}), do: State.changeset(state, attrs)
end
