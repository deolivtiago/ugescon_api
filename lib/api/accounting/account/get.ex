defmodule Api.Accounting.Account.Get do
  @moduledoc false
  alias Api.Accounting.Account
  alias Api.Repo

  @doc false
  def call(id) do
    Account
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> Account.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
