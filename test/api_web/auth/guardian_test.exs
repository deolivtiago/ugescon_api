defmodule ApiWeb.Auth.GuardianTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias ApiWeb.Auth.Guardian

  describe "subject_for_token/2:" do
    setup [:build_user]

    test "returns :ok when user is valid", %{user: user} do
      assert {:ok, user.id} == Guardian.subject_for_token(user, %{})
    end

    test "returns :error when user is invalid" do
      assert {:error, :unhandled_resource_type} == Guardian.subject_for_token(%{}, %{})
    end
  end

  describe "resource_from_claims/2:" do
    setup [:build_user]

    test "returns :ok when token has valid user id", %{user: user} do
      assert {:ok, user} == Guardian.resource_from_claims(%{"sub" => user.id})
    end

    test "returns :error when token has no id" do
      assert {:error, :unhandled_resource_type} == Guardian.resource_from_claims(%{})
    end
  end

  defp build_user(_) do
    :user
    |> insert()
    |> Api.Repo.preload(:person)
    |> then(&{:ok, user: &1})
  end
end
