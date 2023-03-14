defmodule Api.Registry.List do
  @moduledoc false
  alias Api.Registry.Person
  alias Api.Repo

  @doc false
  def call, do: Repo.all(Person)
end
