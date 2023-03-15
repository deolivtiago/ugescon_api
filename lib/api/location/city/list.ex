defmodule Api.Location.City.List do
  @moduledoc false
  alias Api.Location.City
  alias Api.Repo

  @doc false
  def call, do: Repo.all(City)
end
