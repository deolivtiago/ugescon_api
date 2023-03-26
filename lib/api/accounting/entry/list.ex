defmodule Api.Accounting.Entry.List do
  @moduledoc false
  import Ecto.Query, only: [from: 2]

  alias Api.Accounting.Entry
  alias Api.Repo

  @doc false
  def call do
    Entry
    |> Repo.all()
    |> Repo.preload([:debit_account, :credit_account])
  end

  def call(person_id: person_id) do
    query =
      from e in Entry,
        where: e.person_id == ^person_id

    query
    |> Repo.all()
    |> Repo.preload([:debit_account, :credit_account])
  end
end
