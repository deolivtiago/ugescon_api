defmodule Api.UserManagement.Delete do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call(%User{} = user), do: Repo.delete(user)
end
