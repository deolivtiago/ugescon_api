defmodule Api.Accounting.Account.Change do
  @moduledoc false
  alias Api.Accounting.Account

  @doc false
  def call(%Account{} = account, attrs \\ %{}), do: Account.changeset(account, attrs)
end
