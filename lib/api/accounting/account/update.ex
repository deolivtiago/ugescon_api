defmodule Api.Accounting.Account.Update do
  @moduledoc false
  alias Api.Accounting.Account
  alias Api.Repo

  @doc false
  def call(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end
end
