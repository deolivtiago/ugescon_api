defmodule Api.Accounting.Account.Delete do
  @moduledoc false
  alias Api.Accounting.Account
  alias Api.Repo

  @doc false
  def call(%Account{} = account), do: Repo.delete(account)
end
