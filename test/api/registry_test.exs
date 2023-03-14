defmodule Api.RegistryTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Registry
  alias Api.Registry.Person
  alias Ecto.Changeset

  setup do
    attrs = params_for(:person)

    {:ok, attrs: attrs}
  end

  describe "list_persons/0" do
    test "without persons returns an empty list" do
      assert [] == Registry.list_persons()
    end

    test "with persons returns all persons" do
      person = insert(:person)

      assert [person] == Registry.list_persons()
    end
  end

  describe "get_person/1 returns :ok" do
    setup [:insert_person]

    test "when the given id is found", %{person: %{id: id} = person} do
      assert {:ok, %Person{} = ^person} = Registry.get_person(id)
    end
  end

  describe "get_person/1 returns :error" do
    test "when the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = Registry.get_person(id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "create_person/1 returns :ok" do
    test "when the person attributes are valid", %{attrs: attrs} do
      assert {:ok, %Person{} = person} = Registry.create_person(attrs)

      assert attrs.name == person.name
      assert attrs.alias == person.alias
      assert attrs.social_id == person.social_id
      assert Enum.at(Ecto.Enum.values(Person, :type), attrs.type) == person.type
    end
  end

  describe "create_person/1 returns :error" do
    test "when the person attributes are invalid" do
      attrs = %{alias: "?", name: nil, social_id: "?", type: 6}

      assert {:error, changeset} = Registry.create_person(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.name == ["can't be blank"]
      assert errors.social_id == ["must contain only numbers"]
      assert errors.type == ["is invalid"]
    end

    test "when the person attributes is not provided" do
      assert {:error, changeset} = Registry.create_person()
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.name == ["can't be blank"]
      assert errors.type == ["can't be blank"]
    end

    test "when the person social_id already exists", %{attrs: attrs} do
      attrs =
        insert(:person)
        |> then(&Map.put(attrs, :social_id, &1.social_id))

      assert {:error, changeset} = Registry.create_person(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["has already been taken"] == errors.social_id
    end
  end

  describe "update_person/2 returns :ok" do
    setup [:insert_person]

    test "when the person attributes are valid", %{person: person, attrs: attrs} do
      assert {:ok, %Person{} = person} = Registry.update_person(person, attrs)

      assert attrs.name == person.name
      assert attrs.alias == person.alias
      assert attrs.social_id == person.social_id
      assert Enum.at(Ecto.Enum.values(Person, :type), attrs.type) == person.type
    end
  end

  describe "update_person/2 returns :error" do
    setup [:insert_person]

    test "when the person attributes are invalid", %{person: person} do
      invalid_attrs = %{alias: "@", social_id: "?", name: "a", type: nil}

      assert {:error, changeset} = Registry.update_person(person, invalid_attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["should be at least 2 character(s)"] == errors.name
      assert ["can't be blank"] == errors.type
      assert {:ok, person} == Registry.get_person(person.id)
    end
  end

  describe "delete_person/1" do
    setup [:insert_person]

    test "deletes the person", %{person: person} do
      assert {:ok, %Person{}} = Registry.delete_person(person)

      assert {:error, changeset} = Registry.get_person(person.id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "change_person/1" do
    setup [:insert_person]

    test "returns a changeset", %{person: person} do
      assert %Changeset{} = Registry.change_person(person)
    end
  end

  defp insert_person(_) do
    :person
    |> insert()
    |> then(&{:ok, person: &1})
  end
end
