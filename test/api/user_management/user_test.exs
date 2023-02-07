defmodule Api.UserManagement.UserTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.UserManagement.User
  alias Ecto.Changeset

  setup do
    attrs = params_for(:user)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when email is valid", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, String.upcase(attrs.email))

      changeset = User.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.email == String.downcase(attrs.email)
    end

    test "when name is valid", %{attrs: attrs} do
      changeset = User.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.name == attrs.name
    end

    test "when password is valid", %{attrs: attrs} do
      changeset = User.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert String.starts_with?(changeset.changes.password, "$argon2")
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when email is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, nil)

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.email == ["can't be blank"]
    end

    test "when email is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :email)

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.email == ["can't be blank"]
    end

    test "when email is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, "")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.email == ["can't be blank"]
    end

    test "when email has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, "email.invalid")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.email == ["has invalid format"]
    end

    test "when email is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :email, "@")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.email == ["should be at least 3 character(s)"]
    end

    test "when name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "?")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["should be at least 2 character(s)"]
    end

    test "when name is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, nil)

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :name)

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when password is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :password, "?")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.password == ["should be at least 6 character(s)"]
    end

    test "when password is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :password, nil)

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.password == ["can't be blank"]
    end

    test "when password is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :password)

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.password == ["can't be blank"]
    end

    test "when password is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :password, "")

      changeset = User.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.password == ["can't be blank"]
    end
  end
end
