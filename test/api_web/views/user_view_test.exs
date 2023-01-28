defmodule ApiWeb.UserViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias ApiWeb.UserView

  describe "render/3 returns success" do
    setup [:build_user]

    test "with a list of users", %{user: user} do
      assert %{success: true, data: [user_data]} = render(UserView, "index.json", users: [user])

      assert user_data.id == user.id
      assert user_data.email == user.email
      assert user_data.name == user.name
    end

    test "with a single user", %{user: user} do
      assert %{success: true, data: user_data} = render(UserView, "show.json", user: user)

      assert user_data.id == user.id
      assert user_data.email == user.email
      assert user_data.name == user.name
    end

    test "with user data", %{user: user} do
      assert user_data = render(UserView, "user.json", user: user)

      assert user_data.id == user.id
      assert user_data.email == user.email
      assert user_data.name == user.name
    end
  end

  defp build_user(_) do
    :user
    |> build()
    |> then(&{:ok, user: &1})
  end
end
