defmodule ApiWeb.AuthController do
  @moduledoc """
  Controller responsible for handling auth
  """
  use ApiWeb, :controller

  alias Api.UserManagement
  alias ApiWeb.Auth

  action_fallback ApiWeb.FallbackController

  def signup(conn, %{"user" => %{"password" => password} = user_params}) do
    with {:ok, user} <- UserManagement.create_user(user_params),
         {:ok, data} <- Auth.authenticate(user, password) do
      conn
      |> put_status(:created)
      |> render("auth.json", data: data)
    end
  end

  def signin(conn, %{"credentials" => %{"email" => email, "password" => password}}) do
    with {:ok, user} <- UserManagement.get_user(email: email),
         {:ok, data} <- Auth.authenticate(user, password) do
      render(conn, "auth.json", data: data)
    end
  end
end
