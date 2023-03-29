defmodule Api.Registry.Address.Update do
  @moduledoc false
  alias Api.Registry.Address
  alias Api.Repo

  @doc false
  def call(%Address{} = address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, address} -> {:ok, Repo.preload(address, city: [state: :country])}
      error -> error
    end
  end
end
