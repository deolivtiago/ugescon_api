defmodule ApiWeb.CityControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_city, :put_auth]

    test "with a list of cities when there are cities", %{conn: conn, city: city} do
      conn =
        get(
          conn,
          Routes.country_state_city_path(conn, :index, city.state.country_id, city.state_id)
        )

      assert %{"success" => true, "data" => [city_data]} = json_response(conn, 200)

      assert city_data["id"] == city.id
      assert city_data["name"] == city.name
      assert city_data["state_id"] == city.state_id
    end
  end

  describe "create/2 returns success" do
    setup [:insert_city, :put_auth]

    test "when the city parameters are valid", %{conn: conn, city: city} do
      city_params = params_for(:city)

      conn =
        post(
          conn,
          Routes.country_state_city_path(conn, :create, city.state.country_id, city.state_id),
          city: city_params
        )

      assert %{"success" => true, "data" => city_data} = json_response(conn, 201)

      assert city_data["name"] == city_params.name
      assert city_data["state_id"] == city.state_id
    end
  end

  describe "create/2 returns error" do
    setup [:insert_city, :put_auth]

    test "when the city parameters are invalid", %{conn: conn, city: city} do
      city_params = %{name: "?", code: "??"}

      conn =
        post(
          conn,
          Routes.country_state_city_path(conn, :create, city.state.country_id, city.state_id),
          city: city_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["name"] == ["should be at least 2 character(s)"]
    end

    test "when the state id is not found", %{conn: conn, city: city} do
      city_params = params_for(:city)

      conn =
        post(
          conn,
          Routes.country_state_city_path(conn, :create, city.state.country_id, @id_not_found),
          city: city_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_city, :put_auth]

    test "when the city id is found", %{conn: conn, city: city} do
      conn =
        get(
          conn,
          Routes.country_state_city_path(conn, :show, city.state.country_id, city.state_id, city)
        )

      assert %{"success" => true, "data" => city_data} = json_response(conn, 200)

      assert city_data["id"] == city.id
      assert city_data["name"] == city.name
      assert city_data["state_id"] == city.state_id
    end
  end

  describe "show/2 returns error" do
    setup [:insert_city, :put_auth]

    test "when the city id is not found", %{conn: conn, city: city} do
      conn =
        get(
          conn,
          Routes.country_state_city_path(
            conn,
            :show,
            city.state.country_id,
            city.state_id,
            @id_not_found
          )
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end

    test "when the state id is not found", %{conn: conn, city: city} do
      conn =
        get(
          conn,
          Routes.country_state_city_path(conn, :show, city.state.country_id, @id_not_found, city)
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_city, :put_auth]

    test "when the city parameters are valid", %{conn: conn, city: city} do
      city_params = params_for(:city)

      conn =
        put(
          conn,
          Routes.country_state_city_path(
            conn,
            :update,
            city.state.country_id,
            city.state_id,
            city
          ),
          city: city_params
        )

      assert %{"success" => true, "data" => city_data} = json_response(conn, 200)

      assert city_data["id"] == city.id
      assert city_data["name"] == city_params.name
      assert city_data["state_id"] == city_params.state_id
    end
  end

  describe "update/2 returns error" do
    setup [:insert_city, :put_auth]

    test "when the city parameters are invalid", %{conn: conn, city: city} do
      city_params = %{name: "?", code: nil}

      conn =
        put(
          conn,
          Routes.country_state_city_path(
            conn,
            :update,
            city.state.country_id,
            city.state_id,
            city
          ),
          city: city_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["name"] == ["should be at least 2 character(s)"]
    end

    test "when the state id is not found", %{conn: conn, city: city} do
      city_params = params_for(:city)

      conn =
        put(
          conn,
          Routes.country_state_city_path(
            conn,
            :update,
            city.state.country_id,
            @id_not_found,
            city
          ),
          city: city_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_city, :put_auth]

    test "when the city is found", %{conn: conn, city: city} do
      conn =
        delete(
          conn,
          Routes.country_state_city_path(
            conn,
            :delete,
            city.state.country_id,
            city.state_id,
            city
          )
        )

      assert response(conn, 204)

      conn =
        get(
          conn,
          Routes.country_state_city_path(conn, :show, city.state.country_id, city.state_id, city)
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_city, :put_auth]

    test "when the city is not found", %{conn: conn, city: city} do
      conn =
        delete(
          conn,
          Routes.country_state_city_path(
            conn,
            :delete,
            city.state.country_id,
            city.state_id,
            @id_not_found
          )
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end

    test "when the state is not found", %{conn: conn, city: city} do
      conn =
        delete(
          conn,
          Routes.country_state_city_path(
            conn,
            :delete,
            city.state.country_id,
            @id_not_found,
            city
          )
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_city(_) do
    :city
    |> insert()
    |> Api.Repo.preload(:state)
    |> then(&{:ok, city: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
