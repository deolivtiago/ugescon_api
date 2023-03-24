defmodule Api.Accounting.Entry.Create do
  @moduledoc false
  alias Api.Accounting.Entry
  alias Api.Repo

  @doc false
  def call(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end
end
