defmodule Api.LocationTest do
  use Api.DataCase, async: true

  import Api.Factory

  alias Api.Location
  alias Api.Location.Country
  alias Ecto.Changeset

  describe "list_countries/0" do
    test "without countries returns an empty list" do
      assert [] == Location.list_countries()
    end

    test "with countries returns all countries" do
      country = insert(:country)

      assert [country] == Location.list_countries()
    end
  end

  describe "get_country/1 returns :ok" do
    setup [:insert_country]

    test "when the given id is found", %{country: %{id: id} = country} do
      assert {:ok, %Country{} = ^country} = Location.get_country(id)
    end
  end

  describe "get_country/1 returns :error" do
    test "when the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = Location.get_country(id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "create_country/1 returns :ok" do
    test "when the country attributes are valid" do
      attrs = params_for(:country)

      assert {:ok, %Country{} = country} = Location.create_country(attrs)

      assert attrs.name == country.name
      assert attrs.code == country.code
    end
  end

  describe "create_country/1 returns :error" do
    test "when the country attributes are invalid" do
      attrs = %{code: "??", name: "?"}

      assert {:error, changeset} = Location.create_country(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.name == ["should be at least 2 character(s)"]
      assert errors.code == ["must contain only characters A-Z"]
    end

    test "when the country attributes is not provided" do
      assert {:error, changeset} = Location.create_country()
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.name == ["can't be blank"]
      assert errors.code == ["can't be blank"]
    end

    test "when the country code already exists" do
      attrs =
        params_for(:country)
        |> Map.put(:code, insert(:country).code)

      assert {:error, changeset} = Location.create_country(attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["has already been taken"] == errors.code
    end
  end

  describe "update_country/2 returns :ok" do
    setup [:insert_country]

    test "when the country attributes are valid", %{country: country} do
      attrs = params_for(:country)

      assert {:ok, %Country{} = country} = Location.update_country(country, attrs)

      assert attrs.name == country.name
      assert attrs.code == country.code
    end
  end

  describe "update_country/2 returns :error" do
    setup [:insert_country]

    test "when the country attributes are invalid", %{country: country} do
      invalid_attrs = %{code: nil, name: "a"}

      assert {:error, changeset} = Location.update_country(country, invalid_attrs)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert ["should be at least 2 character(s)"] == errors.name
      assert ["can't be blank"] == errors.code
      assert {:ok, country} == Location.get_country(country.id)
    end
  end

  describe "delete_country/1" do
    setup [:insert_country]

    test "deletes the country", %{country: country} do
      assert {:ok, %Country{}} = Location.delete_country(country)

      assert {:error, changeset} = Location.get_country(country.id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  describe "change_country/1" do
    setup [:insert_country]

    test "returns a changeset", %{country: country} do
      assert %Changeset{} = Location.change_country(country)
    end
  end

  describe "get_city/1 returns :error" do
    test "when the given id is not found" do
      id = Ecto.UUID.generate()

      assert {:error, changeset} = Location.get_city(id)
      errors = errors_on(changeset)

      refute changeset.valid?
      assert errors.id == ["not found"]
    end
  end

  defp insert_country(_) do
    :country
    |> insert()
    |> then(&{:ok, country: &1})
  end

  def unload(struct, field, cardinality \\ :one) do
    %{
      struct
      | field => %Ecto.Association.NotLoaded{
          __field__: field,
          __owner__: struct.__struct__,
          __cardinality__: cardinality
        }
    }
  end
end
