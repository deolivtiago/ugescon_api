defmodule ApiWeb.Auth do
  @moduledoc """
  The auth context
  """
  alias Api.UserManagement.User
  alias ApiWeb.Auth.Guardian
  alias Argon2

  def authenticate(user, password) do
    if Argon2.verify_pass(password, user.password) do
      {:ok, generate_token(user)}
    else
      :email
      |> User.invalid_changeset(user.email, "invalid credentials")
      |> Ecto.Changeset.add_error(:password, "invalid credentials")
      |> then(&{:error, &1})
    end
  end

  def generate_token(%User{} = user) do
    %{
      user: user,
      token:
        %{type: "bearer"}
        |> put_token(:access, user)
        |> put_token(:refresh, user)
    }
  end

  defp put_token(map, :access, user) do
    with {:ok, token, _claims} <-
           Guardian.encode_and_sign(user, %{}, token_type: "access", ttl: {1, :hour}) do
      Map.put(map, :access, token)
    end
  end

  defp put_token(map, :refresh, user) do
    with {:ok, token, _claims} <-
           Guardian.encode_and_sign(user, %{}, token_type: "refresh", ttl: {48, :hour}) do
      Map.put(map, :refresh, token)
    end
  end
end
