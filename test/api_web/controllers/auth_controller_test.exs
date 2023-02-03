defmodule ApiWeb.AuthControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns ok status" do
    setup [:put_auth]

    test "when the auth headers is valid", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert response(conn, 200)
    end
  end

  describe "index/2 returns unauthorized status" do
    test "when the auth headers is invalid", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert response(conn, 401)
    end
  end

  describe "signup/2 returns success" do
    setup [:put_auth]

    test "when the user parameters are valid", %{conn: conn} do
      user_params = params_for(:user)

      conn = post(conn, Routes.auth_path(conn, :signup), user: user_params)

      assert %{"success" => true, "data" => data} = json_response(conn, 201)

      assert data["user"]["email"] == user_params.email
      assert data["user"]["name"] == user_params.name

      assert data["token"]["type"] == "bearer"
      assert data["token"]["access"]
      assert data["token"]["refresh"]
    end
  end

  describe "signup/2 returns error" do
    setup [:put_auth]

    test "when the user parameters are invalid", %{conn: conn} do
      user_params = %{email: "?", name: nil, password: "?"}

      conn = post(conn, Routes.auth_path(conn, :signup), user: user_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["email"] == ["has invalid format", "should be at least 3 character(s)"]
      assert errors["name"] == ["can't be blank"]
      assert errors["password"] == ["should be at least 6 character(s)"]
    end
  end

  describe "signin/2 returns success" do
    setup [:put_auth]

    test "when the credentials are valid", %{conn: conn} do
      credentials = %{email: "some@mail.com", password: "123456"}

      conn = post(conn, Routes.auth_path(conn, :signin), credentials: credentials)

      assert %{"success" => true, "data" => data} = json_response(conn, 200)

      assert data["user"]["email"] == credentials.email

      assert data["token"]["type"] == "bearer"
      assert data["token"]["access"]
      assert data["token"]["refresh"]
    end
  end

  describe "signin/2 returns error" do
    setup [:put_auth]

    test "when the password is invalid", %{conn: conn} do
      credentials = %{email: "some@mail.com", password: "invalid_password"}

      conn = post(conn, Routes.auth_path(conn, :signin), credentials: credentials)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["email"] == ["invalid credentials"]
      assert errors["password"] == ["invalid credentials"]
    end

    test "when the email is invalid", %{conn: conn} do
      credentials = %{email: "invalid@mail.com", password: "123456"}

      conn = post(conn, Routes.auth_path(conn, :signin), credentials: credentials)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["email"] == ["not found"]
    end
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
