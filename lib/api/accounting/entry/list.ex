defmodule Api.Accounting.Entry.List do
  @moduledoc false
  alias Api.Accounting.Entry
  alias Api.Repo

  @doc false
  def call, do: Repo.all(Entry)
end
