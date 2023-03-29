defmodule Api.Registry.Person.Create do
  @moduledoc false
  alias Api.Registry.Person
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end
end
