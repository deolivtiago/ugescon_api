defmodule ApiWeb.AccountController do
  @moduledoc """
  Controller responsible for handling accounts
  """
  use ApiWeb, :controller

  alias Api.Accounting
  alias Api.Accounting.Account

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list accounts
  """
  def index(conn, _params) do
    accounts = Accounting.list_accounts()

    render(conn, "index.json", accounts: accounts)
  end

  @doc """
  Handles requests to create account
  """
  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounting.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  @doc """
  Handles requests to show account
  """
  def show(conn, %{"id" => id}) do
    with {:ok, account} <- Accounting.get_account(id) do
      render(conn, "show.json", account: account)
    end
  end

  @doc """
  Handles requests to update account
  """
  def update(conn, %{"id" => id, "account" => account_params}) do
    with {:ok, account} <- Accounting.get_account(id),
         {:ok, %Account{} = account} <- Accounting.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  @doc """
  Handles requests to delete account
  """
  def delete(conn, %{"id" => id}) do
    with {:ok, account} <- Accounting.get_account(id),
         {:ok, %Account{}} <- Accounting.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
