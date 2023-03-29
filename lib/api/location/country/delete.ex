defmodule Api.Location.Country.Delete do
  @moduledoc false
  alias Api.Location.Country
  alias Api.Repo

  @doc false
  def call(%Country{} = country), do: Repo.delete(country)
end
