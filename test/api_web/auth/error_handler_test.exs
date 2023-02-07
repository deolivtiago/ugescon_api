defmodule ApiWeb.Auth.ErrorHandlerTest do
  use ApiWeb.ConnCase, async: true

  alias ApiWeb.Auth.ErrorHandler

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "auth_error/3:" do
    test "returns unauthorized status when guardian returns :invalid_token", %{conn: conn} do
      conn = ErrorHandler.auth_error(conn, {:invalid_token, :invalid_token}, %{})

      assert response(conn, 401)
    end

    test "returns unauthorized status when guardian returns :no_resource_found", %{conn: conn} do
      conn = ErrorHandler.auth_error(conn, {:no_resource_found, :no_resource_found}, %{})

      assert response(conn, 401)
    end

    test "returns forbidden status when guardian returns :unauthenticated", %{conn: conn} do
      conn = ErrorHandler.auth_error(conn, {:unauthenticated, :unauthenticated}, %{})

      assert response(conn, 403)
    end

    test "returns forbidden status when guardian returns :already_authenticated", %{conn: conn} do
      conn = ErrorHandler.auth_error(conn, {:already_authenticated, :already_authenticated}, %{})

      assert response(conn, 403)
    end
  end
end
