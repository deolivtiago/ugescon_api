defmodule Api.UserManagement.User.Update do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> case do
      {:ok, user} -> {:ok, Repo.preload(user, person: [address: [city: [state: :country]]])}
      error -> error
    end
  end
end
