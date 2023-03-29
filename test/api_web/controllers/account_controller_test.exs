defmodule ApiWeb.AccountControllerTest do
  use ApiWeb.ConnCase

  import Api.Factory

  alias Api.Accounting.Account

  @id_not_found Ecto.UUID.generate()

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2 returns success" do
    setup [:insert_account, :put_auth]

    test "with a list of accounts when there are accounts", %{conn: conn, account: account} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert %{"success" => true, "data" => [account_data]} = json_response(conn, 200)

      assert account_data["id"] == account.id
      assert account_data["code"] == account.code
      assert account_data["name"] == account.name
      assert account_data["level"] == account.level
      assert account_data["type"] == Ecto.Enum.mappings(Account, :type)[account.type]
    end
  end

  describe "create/2 returns success" do
    setup [:insert_account, :put_auth]

    test "when the account parameters are valid", %{conn: conn} do
      account_params = params_for(:account)

      conn = post(conn, Routes.account_path(conn, :create), account: account_params)

      assert %{"success" => true, "data" => account_data} = json_response(conn, 201)

      assert account_data["name"] == account_params.name
      assert account_data["code"] == account_params.code
      assert account_data["level"] == account_params.level
      assert account_data["type"] == account_params.type
    end
  end

  describe "create/2 returns error" do
    setup [:insert_account, :put_auth]

    test "when the account parameters are invalid", %{conn: conn} do
      account_params = %{code: "?", name: "?", level: "?", type: nil}

      conn = post(conn, Routes.account_path(conn, :create), account: account_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["type"] == ["can't be blank"]
      assert errors["name"] == ["should be at least 2 character(s)"]
    end
  end

  describe "show/2 returns success" do
    setup [:insert_account, :put_auth]

    test "when the account id is found", %{conn: conn, account: account} do
      conn = get(conn, Routes.account_path(conn, :show, account))

      assert %{"success" => true, "data" => account_data} = json_response(conn, 200)

      assert account_data["id"] == account.id
      assert account_data["code"] == account.code
      assert account_data["name"] == account.name
      assert account_data["level"] == account.level
      assert account_data["type"] == Ecto.Enum.mappings(Account, :type)[account.type]
    end
  end

  describe "show/2 returns error" do
    setup [:insert_account, :put_auth]

    test "when the account id is not found", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :show, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "update/2 returns success" do
    setup [:insert_account, :put_auth]

    test "when the account parameters are valid", %{conn: conn, account: account} do
      account_params = params_for(:account)

      conn = put(conn, Routes.account_path(conn, :update, account), account: account_params)

      assert %{"success" => true, "data" => account_data} = json_response(conn, 200)

      assert account_data["id"] == account.id
      assert account_data["code"] == account_params.code
      assert account_data["name"] == account_params.name
      assert account_data["level"] == account_params.level
      assert account_data["type"] == account_params.type
    end
  end

  describe "update/2 returns error" do
    setup [:insert_account, :put_auth]

    test "when the account parameters are invalid", %{conn: conn, account: account} do
      account_params = %{code: "@", name: nil, level: "666", type: 666}

      conn = put(conn, Routes.account_path(conn, :update, account), account: account_params)

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["name"] == ["can't be blank"]
      assert errors["level"] == ["must be less than 5"]
      assert errors["type"] == ["is invalid"]
    end
  end

  describe "delete/2 returns success" do
    setup [:insert_account, :put_auth]

    test "when the account is found", %{conn: conn, account: account} do
      conn = delete(conn, Routes.account_path(conn, :delete, account))
      assert response(conn, 204)

      conn = get(conn, Routes.account_path(conn, :show, account))
      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  describe "delete/2 returns error" do
    setup [:insert_account, :put_auth]

    test "when the account is not found", %{conn: conn} do
      conn = delete(conn, Routes.account_path(conn, :delete, @id_not_found))

      assert %{"success" => false, "errors" => errors} = json_response(conn, 422)

      assert errors["id"] == ["not found"]
    end
  end

  defp insert_account(_) do
    :account
    |> insert()
    |> then(&{:ok, account: &1})
  end

  defp put_auth(%{conn: conn}) do
    %{token: %{access: token}} = build(:auth)

    conn
    |> put_req_header("authorization", "Bearer #{token}")
    |> then(&{:ok, conn: &1})
  end
end
