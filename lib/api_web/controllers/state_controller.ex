defmodule ApiWeb.StateController do
  @moduledoc """
  Controller responsible for handling states
  """
  use ApiWeb, :controller

  alias Api.Location
  alias Api.Location.State

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list states
  """
  def index(conn, _params) do
    states = Location.list_states()

    render(conn, "index.json", states: states)
  end

  @doc """
  Handles requests to create state
  """
  def create(conn, %{"state" => state_params}) do
    with {:ok, %State{} = state} <- Location.create_state(state_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.state_path(conn, :show, state))
      |> render("show.json", state: state)
    end
  end

  @doc """
  Handles requests to show state
  """
  def show(conn, %{"id" => id}) do
    with {:ok, state} <- Location.get_state(id) do
      render(conn, "show.json", state: state)
    end
  end

  @doc """
  Handles requests to update state
  """
  def update(conn, %{"id" => id, "state" => state_params}) do
    with {:ok, state} <- Location.get_state(id),
         {:ok, %State{} = state} <- Location.update_state(state, state_params) do
      render(conn, "show.json", state: state)
    end
  end

  @doc """
  Handles requests to delete state
  """
  def delete(conn, %{"id" => id}) do
    with {:ok, state} <- Location.get_state(id),
         {:ok, %State{}} <- Location.delete_state(state) do
      send_resp(conn, :no_content, "")
    end
  end
end
