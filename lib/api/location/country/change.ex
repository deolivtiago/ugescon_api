defmodule Api.Location.Country.Change do
  @moduledoc false
  alias Api.Location.Country

  @doc false
  def call(%Country{} = country, attrs \\ %{}), do: Country.changeset(country, attrs)
end
