defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_user, :put_auth]

    test "with a list of users when there are users", %{conn: conn, user: user} do
      %{id: id, email: email, name: name} = user

      conn = get(conn, Routes.user_path(conn, :index))

      assert %{"success" => true, "data" => [user, _auth_user]} = json_response(conn, 200)

      assert user["id"] == id
      assert user["email"] == email
      assert user["name"] == name
    end
  end

  describe "create/2 returns success" do
    setup [:insert_user, :put_auth]

    test "when the user parameters are valid", %{conn: conn} do
      user_params = params_for(:user)

      conn = post(conn, Routes.user_path(conn, :create), user: user_params)

      assert %{"success" => true, "data" => user_data} = json_response(conn, 201)

      assert user_data["email"] == user_params.email
      assert user_data["name"] == user_params.name
    end
  end

  describe "create/2 returns error" do
    setup [:insert_user, :put_auth]

    test "when the user parameters are invalid", %{conn: conn} do
      user_params = %{email: "?", name: nil, password: "?"}

      conn = post(conn, Routes.user_path(conn, :create), user: user_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["email"] == ["has invalid format", "should be at least 3 character(s)"]
      assert errors["name"] == ["can't be blank"]
      assert errors["password"] == ["should be at least 6 character(s)"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_user, :put_auth]

    test "when the user id is found", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :show, user))

      assert %{"success" => true, "data" => user_data} = json_response(conn, 200)

      assert user_data["id"] == user.id
      assert user_data["email"] == user.email
      assert user_data["name"] == user.name
    end
  end

  describe "show/2 returns error" do
    setup [:insert_user, :put_auth]

    test "when the user id is not found", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :show, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_user, :put_auth]

    test "when the user parameters are valid", %{conn: conn, user: user} do
      user_params = params_for(:user)

      conn = put(conn, Routes.user_path(conn, :update, user), user: user_params)

      assert %{"success" => true, "data" => user_data} = json_response(conn, 200)

      assert user_data["id"] == user.id
      assert user_data["email"] == user_params.email
      assert user_data["name"] == user_params.name
    end
  end

  describe "update/2 returns error" do
    setup [:insert_user, :put_auth]

    test "when the user parameters are invalid", %{conn: conn, user: user} do
      user_params = %{email: "@", name: "?", password: nil}

      conn = put(conn, Routes.user_path(conn, :update, user), user: user_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["email"] == ["should be at least 3 character(s)"]
      assert errors["name"] == ["should be at least 2 character(s)"]
      assert errors["password"] == ["can't be blank"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_user, :put_auth]

    test "when the user is found", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_user, :put_auth]

    test "when the user is not found", %{conn: conn} do
      conn = delete(conn, Routes.user_path(conn, :delete, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_user(_) do
    :user
    |> insert()
    |> then(&{:ok, user: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
