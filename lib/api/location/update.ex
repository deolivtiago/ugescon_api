defmodule Api.Location.Update do
  @moduledoc false
  alias Api.Location.Country
  alias Api.Repo

  @doc false
  def call(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end
end
