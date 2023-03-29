defmodule ApiWeb.PersonView do
  @moduledoc """
  View responsible for rendering persons
  """
  use ApiWeb, :view

  alias Api.Registry.Person
  alias ApiWeb.AddressView
  alias ApiWeb.PersonView

  @doc """
  Renders a list of persons
  """
  def render("index.json", %{persons: persons}) do
    %{success: true, data: render_many(persons, PersonView, "person.json")}
  end

  @doc """
  Renders a single person
  """
  def render("show.json", %{person: person}) do
    %{success: true, data: render_one(person, PersonView, "person.json")}
  end

  @doc """
  Renders a person data
  """
  def render("person.json", %{person: person}) do
    %{
      id: person.id,
      type: Ecto.Enum.mappings(Person, :type)[person.type],
      name: person.name,
      alias: person.alias,
      social_id: person.social_id,
      address: render_one(person.address, AddressView, "address.json")
    }
  end
end
