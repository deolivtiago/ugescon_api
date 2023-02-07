defmodule ApiWeb.UserController do
  @moduledoc """
  Controller responsible for handling users
  """
  use ApiWeb, :controller

  alias Api.UserManagement
  alias Api.UserManagement.User

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list users
  """
  def index(conn, _params) do
    users = UserManagement.list_users()

    render(conn, "index.json", users: users)
  end

  @doc """
  Handles requests to create user
  """
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserManagement.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  @doc """
  Handles requests to show user
  """
  def show(conn, %{"id" => id}) do
    with {:ok, user} <- UserManagement.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  @doc """
  Handles requests to update user
  """
  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, user} <- UserManagement.get_user(id),
         {:ok, %User{} = user} <- UserManagement.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  @doc """
  Handles requests to delete user
  """
  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- UserManagement.get_user(id),
         {:ok, %User{}} <- UserManagement.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
