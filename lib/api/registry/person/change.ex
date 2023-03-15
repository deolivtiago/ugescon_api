defmodule Api.Registry.Person.Change do
  @moduledoc false
  alias Api.Registry.Person

  @doc false
  def call(%Person{} = person, attrs \\ %{}), do: Person.changeset(person, attrs)
end
