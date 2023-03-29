defmodule Api.Location.City.Create do
  @moduledoc false
  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, city} -> {:ok, Repo.preload(city, state: :country)}
      error -> error
    end
  end
end
