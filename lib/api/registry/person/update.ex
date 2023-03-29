defmodule Api.Registry.Person.Update do
  @moduledoc false
  alias Api.Registry.Person
  alias Api.Repo

  @doc false
  def call(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, person} -> {:ok, Repo.preload(person, address: [city: [state: :country]])}
      error -> error
    end
  end
end
