defmodule Api.UserManagement.User.List do
  @moduledoc false
  alias Api.Repo
  alias Api.UserManagement.User

  @doc false
  def call do
    User
    |> Repo.all()
    |> Repo.preload(person: [address: [city: [state: :country]]])
  end
end
