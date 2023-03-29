defmodule ApiWeb.AddressController do
  @moduledoc """
  Controller responsible for handling addresses
  """
  use ApiWeb, :controller

  alias Api.Registry
  alias Api.Registry.Address

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list addresses
  """
  def index(conn, %{"person_id" => person_id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         addresses <- Registry.list_addresses(person_id: person_id) do
      render(conn, "index.json", addresses: addresses)
    end
  end

  @doc """
  Handles requests to create address
  """
  def create(conn, %{"person_id" => person_id, "address" => address_params}) do
    address_params = Map.put(address_params, "person_id", person_id)

    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, %Address{} = address} <- Registry.create_address(address_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.person_address_path(conn, :show, person_id, address))
      |> render("show.json", address: address)
    end
  end

  @doc """
  Handles requests to show address
  """
  def show(conn, %{"person_id" => person_id, "id" => id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, address} <- Registry.get_address(id) do
      render(conn, "show.json", address: address)
    end
  end

  @doc """
  Handles requests to update address
  """
  def update(conn, %{"person_id" => person_id, "id" => id, "address" => address_params}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, address} <- Registry.get_address(id),
         {:ok, %Address{} = address} <- Registry.update_address(address, address_params) do
      render(conn, "show.json", address: address)
    end
  end

  @doc """
  Handles requests to delete address
  """
  def delete(conn, %{"person_id" => person_id, "id" => id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         {:ok, address} <- Registry.get_address(id),
         {:ok, %Address{}} <- Registry.delete_address(address) do
      send_resp(conn, :no_content, "")
    end
  end
end
