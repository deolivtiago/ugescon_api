defmodule Api.UserManagement.Update do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
