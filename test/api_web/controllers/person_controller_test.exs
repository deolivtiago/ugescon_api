defmodule ApiWeb.PersonControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  alias Api.Registry.Person

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_person, :put_auth]

    test "with a list of persons when there are persons", %{conn: conn, person: person} do
      conn = get(conn, Routes.person_path(conn, :index))

      assert %{"success" => true, "data" => [person_data]} = json_response(conn, 200)

      assert person_data["id"] == person.id
      assert person_data["alias"] == person.alias
      assert person_data["name"] == person.name
      assert person_data["social_id"] == person.social_id
      assert person_data["type"] == Ecto.Enum.mappings(Person, :type)[person.type]
    end
  end

  describe "create/2 returns success" do
    setup [:insert_person, :put_auth]

    test "when the person parameters are valid", %{conn: conn} do
      person_params = params_for(:person)

      conn = post(conn, Routes.person_path(conn, :create), person: person_params)

      assert %{"success" => true, "data" => person_data} = json_response(conn, 201)

      assert person_data["name"] == person_params.name
      assert person_data["alias"] == person_params.alias
      assert person_data["social_id"] == person_params.social_id
      assert person_data["type"] == person_params.type
    end
  end

  describe "create/2 returns error" do
    setup [:insert_person, :put_auth]

    test "when the person parameters are invalid", %{conn: conn} do
      person_params = %{alias: "?", name: "?", social_id: "?", type: nil}

      conn = post(conn, Routes.person_path(conn, :create), person: person_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["type"] == ["can't be blank"]
      assert errors["name"] == ["should be at least 2 character(s)"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_person, :put_auth]

    test "when the person id is found", %{conn: conn, person: person} do
      conn = get(conn, Routes.person_path(conn, :show, person))

      assert %{"success" => true, "data" => person_data} = json_response(conn, 200)

      assert person_data["id"] == person.id
      assert person_data["alias"] == person.alias
      assert person_data["name"] == person.name
      assert person_data["social_id"] == person.social_id
      assert person_data["type"] == Ecto.Enum.mappings(Person, :type)[person.type]
    end
  end

  describe "show/2 returns error" do
    setup [:insert_person, :put_auth]

    test "when the person id is not found", %{conn: conn} do
      conn = get(conn, Routes.person_path(conn, :show, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_person, :put_auth]

    test "when the person parameters are valid", %{conn: conn, person: person} do
      person_params = params_for(:person)

      conn = put(conn, Routes.person_path(conn, :update, person), person: person_params)

      assert %{"success" => true, "data" => person_data} = json_response(conn, 200)

      assert person_data["id"] == person.id
      assert person_data["alias"] == person_params.alias
      assert person_data["name"] == person_params.name
      assert person_data["social_id"] == person_params.social_id
      assert person_data["type"] == person_params.type
    end
  end

  describe "update/2 returns error" do
    setup [:insert_person, :put_auth]

    test "when the person parameters are invalid", %{conn: conn, person: person} do
      person_params = %{alias: "@", name: nil, social_id: "invalid", type: 6}

      conn = put(conn, Routes.person_path(conn, :update, person), person: person_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["name"] == ["can't be blank"]
      assert errors["social_id"] == ["must contain only numbers"]
      assert errors["type"] == ["is invalid"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_person, :put_auth]

    test "when the person is found", %{conn: conn, person: person} do
      conn = delete(conn, Routes.person_path(conn, :delete, person))
      assert response(conn, 204)

      conn = get(conn, Routes.person_path(conn, :show, person))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_person, :put_auth]

    test "when the person is not found", %{conn: conn} do
      conn = delete(conn, Routes.person_path(conn, :delete, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_person(_) do
    :person
    |> insert()
    |> then(&{:ok, person: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
