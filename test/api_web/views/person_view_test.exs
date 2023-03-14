defmodule ApiWeb.PersonViewTest do
  use ApiWeb.ConnCase, async: true

  import Phoenix.View
  import Api.Factory

  alias Api.Registry.Person
  alias ApiWeb.PersonView

  describe "render/3 returns success" do
    setup [:build_person]

    test "with a list of persons", %{person: person} do
      assert %{success: true, data: data} = render(PersonView, "index.json", persons: [person])
      assert [person_data] = data

      assert person_data.id == person.id
      assert person_data.type == Ecto.Enum.mappings(Person, :type)[person.type]
      assert person_data.alias == person.alias
      assert person_data.name == person.name
      assert person_data.social_id == person.social_id
    end

    test "with a single person", %{person: person} do
      assert %{success: true, data: person_data} = render(PersonView, "show.json", person: person)

      assert person_data.id == person.id
      assert person_data.type == Ecto.Enum.mappings(Person, :type)[person.type]
      assert person_data.alias == person.alias
      assert person_data.name == person.name
      assert person_data.social_id == person.social_id
    end

    test "with person data", %{person: person} do
      assert person_data = render(PersonView, "person.json", person: person)

      assert person_data.id == person.id
      assert person_data.type == Ecto.Enum.mappings(Person, :type)[person.type]
      assert person_data.alias == person.alias
      assert person_data.name == person.name
      assert person_data.social_id == person.social_id
    end
  end

  defp build_person(_) do
    :person
    |> build()
    |> then(&Map.put(&1, :type, Enum.at(Ecto.Enum.values(Person, :type), &1.type)))
    |> then(&{:ok, person: &1})
  end
end
