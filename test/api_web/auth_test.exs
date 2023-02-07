defmodule ApiWeb.AuthTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias ApiWeb.Auth

  @password "123456"

  describe "authenticate/2:" do
    setup [:build_user]

    test "returns :ok when the given password is valid", %{user: user} do
      assert {:ok, auth_data} = Auth.authenticate(user, @password)

      assert auth_data.user == user
      assert auth_data.token.access
      assert auth_data.token.refresh
      assert auth_data.token.type == "bearer"
    end

    test "returns :error when the given password is invalid", %{user: user} do
      assert {:error, changeset} = Auth.authenticate(user, "invalid_password")
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.email == ["invalid credentials"]
      assert errors.password == ["invalid credentials"]
    end
  end

  describe "generate_token/1:" do
    setup [:build_user]

    test "returns auth data when user is valid", %{user: user} do
      assert %{user: ^user, token: token} = Auth.generate_token(user)

      assert token.access
      assert token.refresh
      assert token.type == "bearer"
    end
  end

  defp build_user(_) do
    :user
    |> build_and_validate(%{password: @password})
    |> then(&{:ok, user: &1})
  end
end
