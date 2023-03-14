defmodule ApiWeb.PersonController do
  @moduledoc """
  Controller responsible for handling persons
  """
  use ApiWeb, :controller

  alias Api.Registry
  alias Api.Registry.Person

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list persons
  """
  def index(conn, _params) do
    persons = Registry.list_persons()

    render(conn, "index.json", persons: persons)
  end

  @doc """
  Handles requests to create person
  """
  def create(conn, %{"person" => person_params}) do
    with {:ok, %Person{} = person} <- Registry.create_person(person_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.person_path(conn, :show, person))
      |> render("show.json", person: person)
    end
  end

  @doc """
  Handles requests to show person
  """
  def show(conn, %{"id" => id}) do
    with {:ok, person} <- Registry.get_person(id) do
      render(conn, "show.json", person: person)
    end
  end

  @doc """
  Handles requests to update person
  """
  def update(conn, %{"id" => id, "person" => person_params}) do
    with {:ok, person} <- Registry.get_person(id),
         {:ok, %Person{} = person} <- Registry.update_person(person, person_params) do
      render(conn, "show.json", person: person)
    end
  end

  @doc """
  Handles requests to delete person
  """
  def delete(conn, %{"id" => id}) do
    with {:ok, person} <- Registry.get_person(id),
         {:ok, %Person{}} <- Registry.delete_person(person) do
      send_resp(conn, :no_content, "")
    end
  end
end
