defmodule Api.Accounting.Entry.List do
  @moduledoc false
  alias Api.Accounting.Entry
  alias Api.Repo

  @doc false
  def call do
    Entry
    |> Repo.all()
    |> Repo.preload([:debit_account, :credit_account])
  end
end
