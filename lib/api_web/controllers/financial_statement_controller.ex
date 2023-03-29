defmodule ApiWeb.FinancialStatementController do
  @moduledoc """
  Controller responsible for handling financial statement
  """
  use ApiWeb, :controller

  alias Api.Accounting
  alias Api.Registry

  action_fallback ApiWeb.FallbackController

  @doc """
  Handles requests to list financial statement
  """
  def index(conn, %{"person_id" => person_id}) do
    with {:ok, _person} <- Registry.get_person(person_id),
         financial_statement <- Accounting.financial_statement(person_id) do
      render(conn, "index.json", rows: financial_statement)
    end
  end
end
