defmodule Api.Registry.Person.List do
  @moduledoc false
  alias Api.Registry.Person
  alias Api.Repo

  @doc false
  def call do
    Person
    |> Repo.all()
    |> Repo.preload(address: [city: [state: :country]])
  end
end
