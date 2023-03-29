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
      conn = get(conn, Routes.country_state_path(conn, :index, state.country_id))

      assert %{"success" => true, "data" => [state_data]} = json_response(conn, 200)

      assert state_data["id"] == state.id
      assert state_data["name"] == state.name
      assert state_data["code"] == state.code
    end
  end

  describe "show/2 returns success" do
    setup [:insert_state, :put_auth]

    test "when the state id is found", %{conn: conn, state: state} do
      conn = get(conn, Routes.country_state_path(conn, :show, state.country_id, state))

      assert %{"success" => true, "data" => state_data} = json_response(conn, 200)

      assert state_data["id"] == state.id
      assert state_data["name"] == state.name
      assert state_data["code"] == state.code
    end
  end

  describe "show/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the state id is not found", %{conn: conn, state: %{country_id: country_id}} do
      conn = get(conn, Routes.country_state_path(conn, :show, country_id, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end

    test "when the country id is not found", %{conn: conn, state: state} do
      conn = get(conn, Routes.country_state_path(conn, :show, @id_not_found, state))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the country id is not found", %{conn: conn, state: state} do
      state_params = params_for(:state)

      conn =
        put(conn, Routes.country_state_path(conn, :update, @id_not_found, state),
          state: state_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_state, :put_auth]

    test "when the state is found", %{conn: conn, state: state} do
      conn = delete(conn, Routes.country_state_path(conn, :delete, state.country_id, state))
      assert response(conn, 204)

      conn = get(conn, Routes.country_state_path(conn, :show, state.country_id, state))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_state, :put_auth]

    test "when the state is not found", %{conn: conn, state: %{country_id: country_id}} do
      conn = delete(conn, Routes.country_state_path(conn, :delete, country_id, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end

    test "when the country is not found", %{conn: conn, state: state} do
      conn = delete(conn, Routes.country_state_path(conn, :delete, @id_not_found, state))

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
