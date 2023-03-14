defmodule Api.Location.State.List do
  @moduledoc false
  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call, do: Repo.all(State)
end
