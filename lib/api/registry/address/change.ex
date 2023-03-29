defmodule Api.Registry.Address.Change do
  @moduledoc false
  alias Api.Registry.Address

  @doc false
  def call(%Address{} = address, attrs \\ %{}), do: Address.changeset(address, attrs)
end
