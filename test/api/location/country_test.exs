defmodule Api.Location.CountryTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Location.Country
  alias Ecto.Changeset

  setup do
    attrs = params_for(:country)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when name is valid", %{attrs: attrs} do
      changeset = Country.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.name == attrs.name
    end

    test "when code is valid", %{attrs: attrs} do
      changeset = Country.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.code == attrs.code
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when name is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, nil)

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :name)

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "")

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "?")

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["should be at least 2 character(s)"]
    end

    test "when code is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, nil)

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["can't be blank"]
    end

    test "when code is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :code)

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["can't be blank"]
    end

    test "when code is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, "")

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["can't be blank"]
    end

    test "when code is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, "A")

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["should be 2 character(s)"]
    end

    test "when code is invalid", %{attrs: attrs} do
      attrs = Map.put(attrs, :code, "??")

      changeset = Country.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.code == ["must contain only characters A-Z"]
    end
  end
end
