defmodule Api.Location.CityTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Location.City
  alias Ecto.Changeset

  setup do
    attrs = params_for(:city)

    {:ok, attrs: attrs}
  end

  describe "changeset/1 returns a valid changeset" do
    test "when name is valid", %{attrs: attrs} do
      changeset = City.changeset(attrs)

      assert %Changeset{valid?: true} = changeset
      assert changeset.changes.name == attrs.name
    end
  end

  describe "changeset/1 returns an invalid changeset" do
    test "when name is null", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, nil)

      changeset = City.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is not provided", %{attrs: attrs} do
      attrs = Map.delete(attrs, :name)

      changeset = City.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is empty", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "")

      changeset = City.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["can't be blank"]
    end

    test "when name is too short", %{attrs: attrs} do
      attrs = Map.put(attrs, :name, "?")

      changeset = City.changeset(attrs)
      errors = errors_on(changeset)

      assert %Changeset{valid?: false} = changeset
      assert errors.name == ["should be at least 2 character(s)"]
    end
  end
end
