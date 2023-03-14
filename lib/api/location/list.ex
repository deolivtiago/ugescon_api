defmodule Api.Location.List do
  @moduledoc false
  alias Api.Location.Country
  alias Api.Repo

  @doc false
  def call, do: Repo.all(Country)
end
