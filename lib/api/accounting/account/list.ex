defmodule Api.Accounting.Account.List do
  @moduledoc false
  alias Api.Accounting.Account
  alias Api.Repo

  @doc false
  def call, do: Repo.all(Account)
end
