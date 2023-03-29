defmodule Api.Accounting.Entry.Get do
  @moduledoc false
  alias Api.Accounting.Entry
  alias Api.Repo

  @doc false
  def call(id) do
    Entry
    |> Repo.get!(id)
    |> Repo.preload([:debit_account, :credit_account])
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> Entry.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
