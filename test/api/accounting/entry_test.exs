defmodule Api.Accounting.EntryTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Accounting.Entry
  alias Ecto.Changeset

  setup do
    attrs = params_for(:entry)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when name is valid", %{attrs: attrs} do
      changeset = Entry.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.name == attrs.name
    end

    test "when description is valid", %{attrs: attrs} do
      changeset = Entry.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.description == attrs.description
    end

    test "when date is valid", %{attrs: attrs} do
      changeset = Entry.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert DateTime.compare(changeset.changes.date, attrs.date) == :eq
    end

    test "when value is valid", %{attrs: attrs} do
      changeset = Entry.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.value == attrs.value
    end

    test "when type is valid", %{attrs: attrs} do
      changeset = Entry.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.type == Enum.at(Ecto.Enum.values(Entry, :type), attrs.type)
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when date is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, :date, "invalid")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.date == ["is invalid"]
    end

    test "when value is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :value, nil)

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.value == ["can't be blank"]
    end

    test "when value is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :value)

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.value == ["can't be blank"]
    end

    test "when value is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :value, "")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.value == ["can't be blank"]
    end

    test "when value is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, :value, "?")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.value == ["is invalid"]
    end

    test "when debit_account_code is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :debit_account_code, nil)

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.debit_account_code == ["can't be blank"]
    end

    test "when debit_account_code is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :debit_account_code)

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.debit_account_code == ["can't be blank"]
    end

    test "when debit_account_code is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :debit_account_code, "")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.debit_account_code == ["can't be blank"]
    end

    test "when debit_account_code is too long", %{attrs: attrs} do
      attrs = Map.put(attrs, :debit_account_code, "0123456789")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.debit_account_code == ["must be a valid account code"]
    end

    test "when debit_account_code has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :debit_account_code, "???")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.debit_account_code == ["must be a valid account code"]
    end

    test "when credit_account_code is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :credit_account_code, nil)

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.credit_account_code == ["can't be blank"]
    end

    test "when credit_account_code is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :credit_account_code)

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.credit_account_code == ["can't be blank"]
    end

    test "when credit_account_code is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :credit_account_code, "")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.credit_account_code == ["can't be blank"]
    end

    test "when credit_account_code is too long", %{attrs: attrs} do
      attrs = Map.put(attrs, :credit_account_code, "0123456789")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.credit_account_code == ["must be a valid account code"]
    end

    test "when credit_account_code has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :credit_account_code, "???")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.credit_account_code == ["must be a valid account code"]
    end

    test "when type has invalid value", %{attrs: attrs} do
      attrs = Map.put(attrs, :type, "666")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.type == ["is invalid"]
    end

    test "when type is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, :type, "invalid")

      changeset = Entry.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.type == ["is invalid"]
    end
  end
end
