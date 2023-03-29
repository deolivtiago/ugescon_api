defmodule Api.Registry.Address.Delete do
  @moduledoc false
  alias Api.Registry.Address
  alias Api.Repo

  @doc false
  def call(%Address{} = address), do: Repo.delete(address)
end
