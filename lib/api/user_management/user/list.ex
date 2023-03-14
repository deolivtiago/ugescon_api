defmodule Api.UserManagement.User.List do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call, do: Repo.all(User)
end
