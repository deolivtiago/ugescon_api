defmodule Api.AccountingTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Accounting
  alias Api.Accounting.Account
  alias Api.Accounting.Entry
  alias Ecto.Changeset

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
    setup [:params_for_account]

    test "when the account attributes are valid", %{attrs: attrs} do
      assert {:ok, %Account{} = account} = Accounting.create_account(attrs)

      assert attrs.name == account.name
      assert attrs.code == account.code
      assert attrs.level == account.level
      assert Enum.at(Ecto.Enum.values(Account, :type), attrs.type) == account.type
    end
  end

  describe "create_account/1 returns :error" do
    setup [:params_for_account]

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
    setup [:params_for_account, :insert_account]

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

  describe "list_entries/0" do
    test "without entries returns an empty list" do
      assert [] == Accounting.list_entries()
    end

    test "with entries returns all entries" do
      entry = insert(:entry) |> Repo.preload([:debit_account, :credit_account])

      assert [entry] == Accounting.list_entries()
    end
  end

  describe "get_entry/1 returns :ok" do
    setup [:insert_entry]

    test "when the given id is found", %{entry: %{id: id} = entry} do
      assert {:ok, %Entry{} = ^entry} = Accounting.get_entry(id)
    end
  end

  describe "get_entry/1 returns :error" do
    test "when the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = Accounting.get_entry(id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "create_entry/1 returns :ok" do
    setup [:params_for_entry]

    test "when the entry attributes are valid", %{attrs: attrs} do
      assert {:ok, %Entry{} = entry} = Accounting.create_entry(attrs)

      assert attrs.name == entry.name
      assert attrs.value == entry.value
      assert DateTime.compare(attrs.date, entry.date) == :eq
      assert attrs.description == entry.description
      assert attrs.debit_account_code == entry.debit_account_code
      assert attrs.credit_account_code == entry.credit_account_code
      assert Enum.at(Ecto.Enum.values(Entry, :type), attrs.type) == entry.type
    end
  end

  describe "create_entry/1 returns :error" do
    setup [:params_for_entry]

    test "when the entry attributes are invalid" do
      attrs = %{date: "?", credit_account_code: "???", debit_account_code: "?", type: 666}

      assert {:error, changeset} = Accounting.create_entry(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.value == ["can't be blank"]
      assert errors.date == ["is invalid"]
      assert errors.debit_account_code == ["must be a valid account code"]
      assert errors.credit_account_code == ["must be a valid account code"]
      assert errors.type == ["is invalid"]
    end

    test "when the entry attributes is not provided" do
      assert {:error, changeset} = Accounting.create_entry()
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.value == ["can't be blank"]
      assert errors.debit_account_code == ["can't be blank"]
      assert errors.credit_account_code == ["can't be blank"]
      assert errors.type == ["can't be blank"]
    end
  end

  describe "update_entry/2 returns :ok" do
    setup [:params_for_entry, :insert_entry]

    test "when the entry attributes are valid", %{entry: entry, attrs: attrs} do
      assert {:ok, %Entry{} = entry} = Accounting.update_entry(entry, attrs)

      assert attrs.name == entry.name
      assert attrs.value == entry.value
      assert DateTime.compare(attrs.date, entry.date) == :eq
      assert attrs.description == entry.description
      assert attrs.credit_account_code == entry.credit_account_code
      assert attrs.debit_account_code == entry.debit_account_code
      assert attrs.person_id == entry.person_id
      assert Enum.at(Ecto.Enum.values(Entry, :type), attrs.type) == entry.type
    end
  end

  describe "update_entry/2 returns :error" do
    setup [:insert_entry]

    test "when the entry attributes are invalid", %{entry: entry} do
      invalid_attrs = %{value: "@", debit_account_code: "?", credit_account_code: "a", type: nil}

      assert {:error, changeset} = Accounting.update_entry(entry, invalid_attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.value == ["is invalid"]
      assert errors.debit_account_code == ["must be a valid account code"]
      assert errors.credit_account_code == ["must be a valid account code"]
      assert errors.type == ["can't be blank"]
      assert {:ok, entry} == Accounting.get_entry(entry.id)
    end
  end

  describe "delete_entry/1" do
    setup [:insert_entry]

    test "deletes the entry", %{entry: entry} do
      assert {:ok, %Entry{}} = Accounting.delete_entry(entry)

      assert {:error, changeset} = Accounting.get_entry(entry.id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "change_entry/1" do
    setup [:insert_entry]

    test "returns a changeset", %{entry: entry} do
      assert %Changeset{} = Accounting.change_entry(entry)
    end
  end

  defp insert_account(_) do
    :account
    |> insert()
    |> then(&{:ok, account: &1})
  end

  defp insert_entry(_) do
    :entry
    |> insert()
    |> Repo.preload([:debit_account, :credit_account])
    |> then(&{:ok, entry: &1})
  end

  defp params_for_account(_) do
    attrs = params_for(:account)

    {:ok, attrs: attrs}
  end

  defp params_for_entry(_) do
    attrs = params_for(:entry)

    {:ok, attrs: attrs}
  end
end
