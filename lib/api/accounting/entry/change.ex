defmodule Api.Accounting.Entry.Change do
  @moduledoc false
  alias Api.Accounting.Entry

  @doc false
  def call(%Entry{} = entry, attrs \\ %{}), do: Entry.changeset(entry, attrs)
end
