defmodule Api.Location.City.Delete do
  @moduledoc false
  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call(%City{} = city), do: Repo.delete(city)
end
