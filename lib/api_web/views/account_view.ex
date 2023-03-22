defmodule ApiWeb.AccountView do
  @moduledoc """
  View responsible for rendering accounts
  """
  use ApiWeb, :view

  alias Api.Accounting.Account
  alias ApiWeb.AccountView

  @doc """
  Renders a list of accounts
  """
  def render("index.json", %{accounts: accounts}) do
    %{success: true, data: render_many(accounts, AccountView, "account.json")}
  end

  @doc """
  Renders a single account
  """
  def render("show.json", %{account: account}) do
    %{success: true, data: render_one(account, AccountView, "account.json")}
  end

  @doc """
  Renders a account data
  """
  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      code: account.code,
      name: account.name,
      type: Ecto.Enum.mappings(Account, :type)[account.type],
      level: account.level
    }
  end
end
