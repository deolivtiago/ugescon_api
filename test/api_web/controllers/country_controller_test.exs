defmodule ApiWeb.CountryControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_country, :put_auth]

    test "with a list of countries when there are countries", %{conn: conn, country: country} do
      conn = get(conn, Routes.country_path(conn, :index))

      assert %{"success" => true, "data" => [country_data]} = json_response(conn, 200)

      assert country_data["id"] == country.id
      assert country_data["name"] == country.name
      assert country_data["code"] == country.code
    end
  end

  describe "create/2 returns success" do
    setup [:put_auth]

    test "when the country parameters are valid", %{conn: conn} do
      country_params = params_for(:country)

      conn = post(conn, Routes.country_path(conn, :create), country: country_params)

      assert %{"success" => true, "data" => country_data} = json_response(conn, 201)

      assert country_data["name"] == country_params.name
      assert country_data["code"] == country_params.code
    end
  end

  describe "create/2 returns error" do
    setup [:insert_country, :put_auth]

    test "when the country parameters are invalid", %{conn: conn} do
      country_params = %{name: "?", code: "??"}

      conn = post(conn, Routes.country_path(conn, :create), country: country_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["code"] == ["must contain only characters A-Z"]
      assert errors["name"] == ["should be at least 2 character(s)"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_country, :put_auth]

    test "when the country id is found", %{conn: conn, country: country} do
      conn = get(conn, Routes.country_path(conn, :show, country))

      assert %{"success" => true, "data" => country_data} = json_response(conn, 200)

      assert country_data["id"] == country.id
      assert country_data["name"] == country.name
      assert country_data["code"] == country.code
    end
  end

  describe "show/2 returns error" do
    setup [:insert_country, :put_auth]

    test "when the country id is not found", %{conn: conn} do
      conn = get(conn, Routes.country_path(conn, :show, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_country, :put_auth]

    test "when the country parameters are valid", %{conn: conn, country: country} do
      country_params = params_for(:country)

      conn = put(conn, Routes.country_path(conn, :update, country), country: country_params)

      assert %{"success" => true, "data" => country_data} = json_response(conn, 200)

      assert country_data["id"] == country.id
      assert country_data["name"] == country_params.name
      assert country_data["code"] == country_params.code
    end
  end

  describe "update/2 returns error" do
    setup [:insert_country, :put_auth]

    test "when the country parameters are invalid", %{conn: conn, country: country} do
      country_params = %{name: "?", code: nil}

      conn = put(conn, Routes.country_path(conn, :update, country), country: country_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["code"] == ["can't be blank"]
      assert errors["name"] == ["should be at least 2 character(s)"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_country, :put_auth]

    test "when the country is found", %{conn: conn, country: country} do
      conn = delete(conn, Routes.country_path(conn, :delete, country))
      assert response(conn, 204)

      conn = get(conn, Routes.country_path(conn, :show, country))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_country, :put_auth]

    test "when the country is not found", %{conn: conn} do
      conn = delete(conn, Routes.country_path(conn, :delete, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_country(_) do
    :country
    |> insert()
    |> then(&{:ok, country: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
