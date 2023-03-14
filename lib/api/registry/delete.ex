defmodule Api.Registry.Delete do
  @moduledoc false
  alias Api.Registry.Person
  alias Api.Repo

  @doc false
  def call(%Person{} = person), do: Repo.delete(person)
end
