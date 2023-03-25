defmodule ApiWeb.EntryController do
  @moduledoc """
  Controller responsible for handling entries
  """
  use ApiWeb, :controller

  alias Api.Accounting
  alias Api.Accounting.Entry
  alias Api.Registry

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list entries
  """
  def index(conn, %{"person_id" => person_id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         entries <- Accounting.list_entries() do
      render(conn, "index.json", entries: entries)
    end
  end

  @doc """
  Handles requests to create entry
  """
  def create(conn, %{"person_id" => person_id, "entry" => entry_params}) do
    entry_params = Map.put(entry_params, "person_id", person_id)

    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, %Entry{} = entry} <- Accounting.create_entry(entry_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.person_entry_path(conn, :show, person_id, entry))
      |> render("show.json", entry: entry)
    end
  end

  @doc """
  Handles requests to show entry
  """
  def show(conn, %{"person_id" => person_id, "id" => id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, entry} <- Accounting.get_entry(id) do
      render(conn, "show.json", entry: entry)
    end
  end

  @doc """
  Handles requests to update entry
  """
  def update(conn, %{"person_id" => person_id, "id" => id, "entry" => entry_params}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, entry} <- Accounting.get_entry(id),
         {:ok, %Entry{} = entry} <- Accounting.update_entry(entry, entry_params) do
      render(conn, "show.json", entry: entry)
    end
  end

  @doc """
  Handles requests to delete entry
  """
  def delete(conn, %{"person_id" => person_id, "id" => id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, entry} <- Accounting.get_entry(id),
         {:ok, %Entry{}} <- Accounting.delete_entry(entry) do
      send_resp(conn, :no_content, "")
    end
  end
end
