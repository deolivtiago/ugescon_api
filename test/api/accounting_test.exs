defmodule Api.AccountingTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Accounting
  alias Api.Accounting.Account
  alias Ecto.Changeset

  setup do
    attrs = params_for(:account)

    {:ok, attrs: attrs}
  end

  describe "list_accounts/0" do
    test "without accounts returns an empty list" do
      assert [] == Accounting.list_accounts()
    end

    test "with accounts returns all accounts" do
      account = insert(:account)

      assert [account] == Accounting.list_accounts()
    end
  end

  describe "get_account/1 returns :ok" do
    setup [:insert_account]

    test "when the given id is found", %{account: %{id: id} = account} do
      assert {:ok, %Account{} = ^account} = Accounting.get_account(id)
    end
  end

  describe "get_account/1 returns :error" do
    test "when the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = Accounting.get_account(id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "create_account/1 returns :ok" do
    test "when the account attributes are valid", %{attrs: attrs} do
      assert {:ok, %Account{} = account} = Accounting.create_account(attrs)

      assert attrs.name == account.name
      assert attrs.code == account.code
      assert attrs.level == account.level
      assert Enum.at(Ecto.Enum.values(Account, :type), attrs.type) == account.type
    end
  end

  describe "create_account/1 returns :error" do
    test "when the account attributes are invalid" do
      attrs = %{code: "?", name: nil, level: "666", type: 666}

      assert {:error, changeset} = Accounting.create_account(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.name == ["can't be blank"]
      assert errors.level == ["must be less than 5"]
      assert errors.type == ["is invalid"]
    end

    test "when the account attributes is not provided" do
      assert {:error, changeset} = Accounting.create_account()
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.name == ["can't be blank"]
      assert errors.type == ["can't be blank"]
    end

    test "when the account code already exists", %{attrs: attrs} do
      attrs =
        insert(:account)
        |> then(&Map.put(attrs, :code, &1.code))

      assert {:error, changeset} = Accounting.create_account(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["has already been taken"] == errors.code
    end
  end

  describe "update_account/2 returns :ok" do
    setup [:insert_account]

    test "when the account attributes are valid", %{account: account, attrs: attrs} do
      assert {:ok, %Account{} = account} = Accounting.update_account(account, attrs)

      assert attrs.name == account.name
      assert attrs.code == account.code
      assert attrs.level == account.level
      assert Enum.at(Ecto.Enum.values(Account, :type), attrs.type) == account.type
    end
  end

  describe "update_account/2 returns :error" do
    setup [:insert_account]

    test "when the account attributes are invalid", %{account: account} do
      invalid_attrs = %{code: "@", level: "?", name: "a", type: nil}

      assert {:error, changeset} = Accounting.update_account(account, invalid_attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["should be at least 2 character(s)"] == errors.name
      assert ["can't be blank"] == errors.type
      assert {:ok, account} == Accounting.get_account(account.id)
    end
  end

  describe "delete_account/1" do
    setup [:insert_account]

    test "deletes the account", %{account: account} do
      assert {:ok, %Account{}} = Accounting.delete_account(account)

      assert {:error, changeset} = Accounting.get_account(account.id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "change_account/1" do
    setup [:insert_account]

    test "returns a changeset", %{account: account} do
      assert %Changeset{} = Accounting.change_account(account)
    end
  end

  defp insert_account(_) do
    :account
    |> insert()
    |> then(&{:ok, account: &1})
  end
end
