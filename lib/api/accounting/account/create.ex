defmodule Api.Accounting.Account.Create do
  @moduledoc false
  alias Api.Accounting.Account
  alias Api.Repo

  @doc false
  def call(attrs \\ %{})

  @doc false
  def call(attrs) when is_list(attrs) do
    attrs
    |> Enum.map(&Account.changeset/1)
    |> Enum.map(&Repo.insert!/1)
  end

  @doc false
  def call(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
