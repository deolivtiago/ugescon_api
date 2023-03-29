defmodule Api.Location.Country.Create do
  @moduledoc false
  alias Api.Location.Country
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end
end
