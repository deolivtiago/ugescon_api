defmodule ApiWeb.StateControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_state, :put_auth]

    test "with a list of states when there are states", %{conn: conn, state: state} do
      conn = get(conn, Routes.state_path(conn, :index))

      assert %{"success" => true, "data" => [state_data]} = json_response(conn, 200)

      assert state_data["id"] == state.id
      assert state_data["name"] == state.name
      assert state_data["code"] == state.code
    end
  end

  describe "create/2 returns success" do
    setup [:put_auth]

    test "when the state parameters are valid", %{conn: conn} do
      state_params = params_for(:state)

      conn = post(conn, Routes.state_path(conn, :create), state: state_params)

      assert %{"success" => true, "data" => state_data} = json_response(conn, 201)

      assert state_data["name"] == state_params.name
      assert state_data["code"] == state_params.code
    end
  end

  describe "create/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the state parameters are invalid", %{conn: conn} do
      state_params = %{name: "?", code: "??"}

      conn = post(conn, Routes.state_path(conn, :create), state: state_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["code"] == ["must contain only characters A-Z"]
      assert errors["name"] == ["should be at least 2 character(s)"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_state, :put_auth]

    test "when the state id is found", %{conn: conn, state: state} do
      conn = get(conn, Routes.state_path(conn, :show, state))

      assert %{"success" => true, "data" => state_data} = json_response(conn, 200)

      assert state_data["id"] == state.id
      assert state_data["name"] == state.name
      assert state_data["code"] == state.code
    end
  end

  describe "show/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the state id is not found", %{conn: conn} do
      conn = get(conn, Routes.state_path(conn, :show, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_state, :put_auth]

    test "when the state parameters are valid", %{conn: conn, state: state} do
      state_params = params_for(:state)

      conn = put(conn, Routes.state_path(conn, :update, state), state: state_params)

      assert %{"success" => true, "data" => state_data} = json_response(conn, 200)

      assert state_data["id"] == state.id
      assert state_data["name"] == state_params.name
      assert state_data["code"] == state_params.code
    end
  end

  describe "update/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the state parameters are invalid", %{conn: conn, state: state} do
      state_params = %{name: "?", code: nil}

      conn = put(conn, Routes.state_path(conn, :update, state), state: state_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["code"] == ["can't be blank"]
      assert errors["name"] == ["should be at least 2 character(s)"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_state, :put_auth]

    test "when the state is found", %{conn: conn, state: state} do
      conn = delete(conn, Routes.state_path(conn, :delete, state))
      assert response(conn, 204)

      conn = get(conn, Routes.state_path(conn, :show, state))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the state is not found", %{conn: conn} do
      conn = delete(conn, Routes.state_path(conn, :delete, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_state(_) do
    :state
    |> insert()
    |> then(&{:ok, state: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
