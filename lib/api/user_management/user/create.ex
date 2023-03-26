defmodule Api.UserManagement.User.Create do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, user} -> {:ok, Repo.preload(user, :person)}
      error -> error
    end
  end
end
