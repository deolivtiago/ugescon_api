defmodule ApiWeb.CountryController do
  @moduledoc """
  Controller responsible for handling countries
  """
  use ApiWeb, :controller

  alias Api.Location
  alias Api.Location.Country

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list countries
  """
  def index(conn, _params) do
    countries = Location.list_countries()

    render(conn, "index.json", countries: countries)
  end

  @doc """
  Handles requests to create country
  """
  def create(conn, %{"country" => country_params}) do
    with {:ok, %Country{} = country} <- Location.create_country(country_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.country_path(conn, :show, country))
      |> render("show.json", country: country)
    end
  end

  @doc """
  Handles requests to show country
  """
  def show(conn, %{"id" => id}) do
    with {:ok, country} <- Location.get_country(id) do
      render(conn, "show.json", country: country)
    end
  end

  @doc """
  Handles requests to update country
  """
  def update(conn, %{"id" => id, "country" => country_params}) do
    with {:ok, country} <- Location.get_country(id),
         {:ok, %Country{} = country} <- Location.update_country(country, country_params) do
      render(conn, "show.json", country: country)
    end
  end

  @doc """
  Handles requests to delete country
  """
  def delete(conn, %{"id" => id}) do
    with {:ok, country} <- Location.get_country(id),
         {:ok, %Country{}} <- Location.delete_country(country) do
      send_resp(conn, :no_content, "")
    end
  end
end
