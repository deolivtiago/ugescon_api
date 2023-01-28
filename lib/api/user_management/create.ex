defmodule Api.UserManagement.Create do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
