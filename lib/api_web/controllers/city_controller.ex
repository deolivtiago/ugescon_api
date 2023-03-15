defmodule ApiWeb.CityController do
  @moduledoc """
  Controller responsible for handling cities
  """
  use ApiWeb, :controller

  alias Api.Location

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list cities
  """
  def index(conn, %{"country_id" => country_id, "state_id" => state_id}) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, _state} <- Location.get_state(state_id),
         cities <- Location.list_cities() do
      render(conn, "index.json", cities: cities)
    end
  end

  @doc """
  Handles requests to create city
  """
  def create(conn, %{"country_id" => country_id, "state_id" => state_id, "city" => city_params}) do
    city_params = Map.put(city_params, "state_id", state_id)

    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, _state} <- Location.get_state(state_id),
         {:ok, city} <- Location.create_city(city_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.country_state_city_path(conn, :show, country_id, state_id, city)
      )
      |> render("show.json", city: city)
    end
  end

  @doc """
  Handles requests to show city
  """
  def show(conn, %{"country_id" => country_id, "state_id" => state_id, "id" => id}) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, _state} <- Location.get_state(state_id),
         {:ok, city} <- Location.get_city(id) do
      render(conn, "show.json", city: city)
    end
  end

  @doc """
  Handles requests to update city
  """
  def update(conn, %{
        "country_id" => country_id,
        "state_id" => state_id,
        "id" => id,
        "city" => city_params
      }) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, _state} <- Location.get_state(state_id),
         {:ok, city} <- Location.get_city(id),
         {:ok, city} <- Location.update_city(city, city_params) do
      render(conn, "show.json", city: city)
    end
  end

  @doc """
  Handles requests to delete city
  """
  def delete(conn, %{"country_id" => country_id, "state_id" => state_id, "id" => id}) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, _state} <- Location.get_state(state_id),
         {:ok, city} <- Location.get_city(id),
         {:ok, _city} <- Location.delete_city(city) do
      send_resp(conn, :no_content, "")
    end
  end
end
