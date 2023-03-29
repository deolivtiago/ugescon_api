defmodule ApiWeb.EntryControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  alias Api.Accounting.Entry

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_entry, :put_auth]

    test "with a list of entries when there are entries", %{conn: conn, entry: entry} do
      conn = get(conn, Routes.person_entry_path(conn, :index, entry.person_id))

      assert %{"success" => true, "data" => [entry_data]} = json_response(conn, 200)

      assert entry_data["id"] == entry.id
      assert entry_data["name"] == entry.name
      assert entry_data["value"] == entry.value
      assert entry_data["date"] == DateTime.to_iso8601(entry.date)
      assert entry_data["description"] == entry.description
      assert entry_data["person_id"] == entry.person_id
      assert entry_data["type"] == Ecto.Enum.mappings(Entry, :type)[entry.type]
    end
  end

  describe "create/2 returns success" do
    setup [:insert_entry, :put_auth]

    test "when the entry parameters are valid", %{conn: conn, entry: %{person_id: person_id}} do
      entry_params = params_for(:entry)

      conn = post(conn, Routes.person_entry_path(conn, :create, person_id), entry: entry_params)

      assert %{"success" => true, "data" => entry_data} = json_response(conn, 201)

      assert entry_data["value"] == entry_params.value
      assert entry_data["name"] == entry_params.name
      assert entry_data["date"] == DateTime.to_iso8601(entry_params.date)
      assert entry_data["description"] == entry_params.description
      assert entry_data["person_id"] == person_id
      assert entry_data["type"] == entry_params.type
    end
  end

  describe "create/2 returns error" do
    setup [:insert_entry, :put_auth]

    test "when the entry parameters are invalid", %{conn: conn, entry: %{person_id: person_id}} do
      entry_params = %{value: "?", type: nil, credit_account_code: "?", date: "?"}

      conn = post(conn, Routes.person_entry_path(conn, :create, person_id), entry: entry_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["value"] == ["is invalid"]
      assert errors["date"] == ["is invalid"]
      assert errors["debit_account_code"] == ["can't be blank"]
      assert errors["credit_account_code"] == ["must be a valid account code"]
    end

    test "when the person id is not found", %{conn: conn} do
      entry_params = params_for(:entry)

      conn =
        post(conn, Routes.person_entry_path(conn, :create, @id_not_found), entry: entry_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_entry, :put_auth]

    test "when the entry id is found", %{conn: conn, entry: entry} do
      conn = get(conn, Routes.person_entry_path(conn, :show, entry.person_id, entry))

      assert %{"success" => true, "data" => entry_data} = json_response(conn, 200)

      assert entry_data["id"] == entry.id
      assert entry_data["name"] == entry.name
      assert entry_data["value"] == entry.value
      assert entry_data["date"] == DateTime.to_iso8601(entry.date)
      assert entry_data["description"] == entry.description
      assert entry_data["person_id"] == entry.person_id
      assert entry_data["type"] == Ecto.Enum.mappings(Entry, :type)[entry.type]
    end
  end

  describe "show/2 returns error" do
    setup [:insert_entry, :put_auth]

    test "when the entry id is not found", %{conn: conn, entry: %{person_id: person_id}} do
      conn = get(conn, Routes.person_entry_path(conn, :show, person_id, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end

    test "when the person id is not found", %{conn: conn, entry: entry} do
      conn = get(conn, Routes.person_entry_path(conn, :show, @id_not_found, entry))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_entry, :put_auth]

    test "when the entry parameters are valid", %{conn: conn, entry: entry} do
      entry_params = params_for(:entry)

      conn =
        put(conn, Routes.person_entry_path(conn, :update, entry.person_id, entry),
          entry: entry_params
        )

      assert %{"success" => true, "data" => entry_data} = json_response(conn, 200)

      assert entry_data["id"] == entry.id
      assert entry_data["name"] == entry_params.name
      assert entry_data["value"] == entry_params.value
      assert entry_data["date"] == DateTime.to_iso8601(entry_params.date)
      assert entry_data["description"] == entry_params.description
      assert entry_data["person_id"] == entry_params.person_id
      assert entry_data["type"] == entry_params.type
    end
  end

  describe "update/2 returns error" do
    setup [:insert_entry, :put_auth]

    test "when the entry parameters are invalid", %{conn: conn, entry: entry} do
      entry_params = %{value: "?", debit_account_code: "?", credit_account_code: nil, type: 666}

      conn =
        put(conn, Routes.person_entry_path(conn, :update, entry.person_id, entry),
          entry: entry_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["value"] == ["is invalid"]
      assert errors["debit_account_code"] == ["must be a valid account code"]
      assert errors["credit_account_code"] == ["can't be blank"]
      assert errors["type"] == ["is invalid"]
    end

    test "when the person id is not found", %{conn: conn, entry: entry} do
      entry_params = params_for(:entry)

      conn =
        put(conn, Routes.person_entry_path(conn, :update, @id_not_found, entry),
          entry: entry_params
        )

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_entry, :put_auth]

    test "when the entry is found", %{conn: conn, entry: entry} do
      conn = delete(conn, Routes.person_entry_path(conn, :delete, entry.person_id, entry))
      assert response(conn, 204)

      conn = get(conn, Routes.person_entry_path(conn, :show, entry.person_id, entry))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_entry, :put_auth]

    test "when the entry is not found", %{conn: conn, entry: %{person_id: person_id}} do
      conn = delete(conn, Routes.person_entry_path(conn, :delete, person_id, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end

    test "when the person is not found", %{conn: conn, entry: entry} do
      conn = delete(conn, Routes.person_entry_path(conn, :delete, @id_not_found, entry))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_entry(_) do
    :entry
    |> insert()
    |> then(&{:ok, entry: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
