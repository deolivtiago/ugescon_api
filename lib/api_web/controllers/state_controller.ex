defmodule ApiWeb.StateController do
  @moduledoc """
  Controller responsible for handling states
  """
  use ApiWeb, :controller

  alias Api.Location

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list states
  """
  def index(conn, %{"country_id" => country_id}) do
    with {:ok, _country} <- Location.get_country(country_id),
         states <- Location.list_states() do
      render(conn, "index.json", states: states)
    end
  end

  @doc """
  Handles requests to create state
  """
  def create(conn, %{"country_id" => country_id, "state" => state_params}) do
    state_params = Map.put(state_params, "country_id", country_id)

    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, state} <- Location.create_state(state_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.country_state_path(conn, :show, country_id, state))
      |> render("show.json", state: state)
    end
  end

  @doc """
  Handles requests to show state
  """
  def show(conn, %{"country_id" => country_id, "id" => id}) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, state} <- Location.get_state(id) do
      render(conn, "show.json", state: state)
    end
  end

  @doc """
  Handles requests to update state
  """
  def update(conn, %{"country_id" => country_id, "id" => id, "state" => state_params}) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, state} <- Location.get_state(id),
         {:ok, state} <- Location.update_state(state, state_params) do
      render(conn, "show.json", state: state)
    end
  end

  @doc """
  Handles requests to delete state
  """
  def delete(conn, %{"country_id" => country_id, "id" => id}) do
    with {:ok, _country} <- Location.get_country(country_id),
         {:ok, state} <- Location.get_state(id),
         {:ok, _state} <- Location.delete_state(state) do
      send_resp(conn, :no_content, "")
    end
  end
end
