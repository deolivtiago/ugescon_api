defmodule Api.Accounting.AccountTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Accounting.Account
  alias Ecto.Changeset

  setup do
    attrs = params_for(:account)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when level is valid", %{attrs: attrs} do
      changeset = Account.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.level == attrs.level
    end

    test "when name is valid", %{attrs: attrs} do
      changeset = Account.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.name == attrs.name
    end

    test "when code is valid", %{attrs: attrs} do
      changeset = Account.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.code == attrs.code
    end

    test "when type is valid", %{attrs: attrs} do
      changeset = Account.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.type == Enum.at(Ecto.Enum.values(Account, :type), attrs.type)
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when name is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, nil)

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :name)

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "?")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["should be at least 2 character(s)"]
    end

    test "when code is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, nil)

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["can't be blank"]
    end

    test "when code is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :code)

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["can't be blank"]
    end

    test "when code is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, "")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["can't be blank"]
    end

    test "when code has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, "???")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.code == ["must contain only numbers"]
    end

    test "when code is too long", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, "0123456789")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["should be at most 5 character(s)"]
    end

    test "when level is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :level, nil)

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.level == ["can't be blank"]
    end

    test "when level is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :level)

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.level == ["can't be blank"]
    end

    test "when level is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :level, "")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.level == ["can't be blank"]
    end

    test "when level is too long", %{attrs: attrs} do
      attrs = Map.put(attrs, :level, "0123456789")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.level == ["must be less than 5"]
    end

    test "when level has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :level, "invalid_format")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.level == ["is invalid"]
    end

    test "when type has invalid value", %{attrs: attrs} do
      attrs = Map.put(attrs, :type, "666")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.type == ["is invalid"]
    end

    test "when type is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, :type, "invalid")

      changeset = Account.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.type == ["is invalid"]
    end
  end
end
