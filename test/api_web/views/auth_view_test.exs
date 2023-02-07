defmodule ApiWeb.AuthViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias ApiWeb.AuthView

  describe "render/3 returns success" do
    setup [:build_auth]

    test "with auth data", %{auth: %{user: user, token: token} = data} do
      assert %{success: true, data: auth_data} = render(AuthView, "auth.json", data: data)

      assert auth_data.user.id == user.id
      assert auth_data.user.email == user.email
      assert auth_data.user.name == user.name

      assert auth_data.token.type == token.type
      assert auth_data.token.access == token.access
      assert auth_data.token.refresh == token.refresh
    end
  end

  defp build_auth(_) do
    :auth
    |> build()
    |> then(&{:ok, auth: &1})
  end
end
