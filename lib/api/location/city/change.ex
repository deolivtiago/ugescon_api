defmodule Api.Location.City.Change do
  @moduledoc false
  alias Api.Location.City

  @doc false
  def call(%City{} = city, attrs \\ %{}), do: City.changeset(city, attrs)
end
