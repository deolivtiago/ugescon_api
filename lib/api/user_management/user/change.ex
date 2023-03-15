defmodule Api.UserManagement.User.Change do
  @moduledoc false
  alias Api.UserManagement.User

  @doc false
  def call(%User{} = user, attrs \\ %{}), do: User.changeset(user, attrs)
end
