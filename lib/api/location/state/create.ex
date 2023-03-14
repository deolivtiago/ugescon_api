defmodule Api.Location.State.Create do
  @moduledoc false
  alias Api.Location.State
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %State{}
    |> State.changeset(attrs)
    |> Repo.insert()
  end
end
