defmodule Api.Location.City.Create do
  @moduledoc false
  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
    |> Repo.preload(state: :country)
  end
end
