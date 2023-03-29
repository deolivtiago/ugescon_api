defmodule Api.Accounting.Account.Create do
  @moduledoc false
  alias Api.Accounting.Account
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
