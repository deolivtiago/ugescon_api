defmodule Api.UserManagement.Get do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call(id) do
    User
    |> Repo.get!(id)
    |> then(&{:ok, &1})
  rescue
    _ ->
      :id
      |> User.invalid_changeset(id, "not found")
      |> then(&{:error, &1})
  end
end
