defmodule Api.UserManagementTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.UserManagement
  alias Api.UserManagement.User
  alias Ecto.Changeset

  setup do
    attrs = params_for(:user)

    {:ok, attrs: attrs}
  end

  describe "list_users/0" do
    test "without users returns an empty list" do
      assert [] == UserManagement.list_users()
    end

    test "with users returns all users" do
      user = insert(:user) |> Api.Repo.preload(:person)

      assert [user] == UserManagement.list_users()
    end
  end

  describe "get_user/1 returns :ok" do
    setup [:insert_user]

    test "when the given id is found", %{user: %{id: id, email: email, name: name}} do
      assert {:ok, %User{} = user} = UserManagement.get_user(id)

      assert user.id == id
      assert user.email == email
      assert user.name == name
    end

    test "when the given email is found", %{user: %{id: id, email: email, name: name}} do
      assert {:ok, %User{} = user} = UserManagement.get_user(email: email)

      assert user.id == id
      assert user.email == email
      assert user.name == name
    end
  end

  describe "get_user/1 returns :error" do
    test "when the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = UserManagement.get_user(id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end

    test "when the given email is not found" do
      email = Faker.Internet.email()

      assert {:error, changeset} = UserManagement.get_user(email: email)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.email == ["not found"]
    end
  end

  describe "create_user/1 returns :ok" do
    test "when the user attributes are valid", %{attrs: attrs} do
      assert {:ok, %User{} = user} = UserManagement.create_user(attrs)

      assert attrs.email == user.email
      assert attrs.name == user.name
      assert String.starts_with?(user.password, "$argon2")
    end
  end

  describe "create_user/1 returns :error" do
    test "when the user attributes are invalid" do
      attrs = %{email: "?", name: nil, password: "?"}

      assert {:error, changeset} = UserManagement.create_user(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.email == ["has invalid format", "should be at least 3 character(s)"]
      assert errors.name == ["can't be blank"]
      assert errors.password == ["should be at least 6 character(s)"]
    end

    test "when the user attributes is not provided" do
      assert {:error, changeset} = UserManagement.create_user()
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.email == ["can't be blank"]
      assert errors.name == ["can't be blank"]
      assert errors.password == ["can't be blank"]
    end

    test "when the user email already exists", %{attrs: attrs} do
      attrs =
        insert(:user)
        |> then(&Map.put(attrs, :email, &1.email))

      assert {:error, changeset} = UserManagement.create_user(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["has already been taken"] == errors.email
    end
  end

  describe "update_user/2 returns :ok" do
    setup [:insert_user]

    test "when the user attributes are valid", %{user: user, attrs: attrs} do
      assert {:ok, %User{} = user} = UserManagement.update_user(user, attrs)

      assert attrs.email == user.email
      assert attrs.name == user.name
      assert String.starts_with?(user.password, "$argon2")
    end
  end

  describe "update_user/2 returns :error" do
    setup [:insert_user]

    test "when the user attributes are invalid", %{user: user} do
      invalid_attrs = %{email: "@", name: "?", password: nil}

      assert {:error, changeset} = UserManagement.update_user(user, invalid_attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["should be at least 3 character(s)"] == errors.email
      assert ["should be at least 2 character(s)"] == errors.name
      assert ["can't be blank"] == errors.password
    end
  end

  describe "delete_user/1" do
    setup [:insert_user]

    test "deletes the user", %{user: user} do
      assert {:ok, %User{}} = UserManagement.delete_user(user)

      assert {:error, changeset} = UserManagement.get_user(user.id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "change_user/1" do
    setup [:insert_user]

    test "returns a changeset", %{user: user} do
      assert %Changeset{} = UserManagement.change_user(user)
    end
  end

  defp insert_user(_) do
    :user
    |> insert()
    |> then(&{:ok, user: &1})
  end
end
