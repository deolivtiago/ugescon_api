defmodule Api.Location.City.Update do
  @moduledoc false
  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call(%City{} = city, attrs) do
    city
    |> City.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, city} -> {:ok, Repo.preload(city, state: :country)}
      error -> error
    end
  end
end
