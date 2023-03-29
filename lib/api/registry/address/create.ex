defmodule Api.Registry.Address.Create do
  @moduledoc false
  alias Api.Registry.Address
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, address} -> {:ok, Repo.preload(address, city: [state: :country])}
      error -> error
    end
  end
end
