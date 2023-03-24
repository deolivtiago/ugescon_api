defmodule Api.Accounting.Entry.Delete do
  @moduledoc false
  alias Api.Accounting.Entry
  alias Api.Repo

  @doc false
  def call(%Entry{} = entry), do: Repo.delete(entry)
end
