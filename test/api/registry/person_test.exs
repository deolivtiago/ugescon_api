defmodule Api.Registry.PersonTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Registry.Person
  alias Ecto.Changeset

  setup do
    attrs = params_for(:person)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when alias is valid", %{attrs: attrs} do
      changeset = Person.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.alias == attrs.alias
    end

    test "when name is valid", %{attrs: attrs} do
      changeset = Person.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.name == attrs.name
    end

    test "when social_id is valid", %{attrs: attrs} do
      changeset = Person.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.social_id == attrs.social_id
    end

    test "when type is valid", %{attrs: attrs} do
      changeset = Person.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.type == Enum.at(Ecto.Enum.values(Person, :type), attrs.type)
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when name is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, nil)

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :name)

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "")

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "?")

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["should be at least 2 character(s)"]
    end

    test "when social_id has invalid format", %{attrs: attrs} do
      attrs = Map.put(attrs, :social_id, "invalid_format")

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.social_id == ["must contain only numbers"]
    end

    test "when social_id is too long", %{attrs: attrs} do
      attrs = Map.put(attrs, :social_id, "01234567890123456789")

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.social_id == ["should be at most 15 character(s)"]
    end

    test "when type has invalid value", %{attrs: attrs} do
      attrs = Map.put(attrs, :type, "6")

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.type == ["is invalid"]
    end

    test "when type is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, :type, "invalid")

      changeset = Person.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset

      assert errors.type == ["is invalid"]
    end
  end
end
