defmodule ApiWeb.FinancialStatementView do
  @moduledoc """
  View responsible for rendering financial statement
  """
  use ApiWeb, :view

  alias ApiWeb.FinancialStatementView

  @doc """
  Renders a financial statement
  """
  def render("index.json", %{rows: rows}) do
    %{success: true, data: render_many(rows, FinancialStatementView, "row.json", as: :row)}
  end

  @doc """
  Renders a single row of the financial statement
  """
  def render("show.json", %{row: row}) do
    %{success: true, data: render_one(row, FinancialStatementView, "row.json", as: :row)}
  end

  @doc """
  Renders a financial statement row data
  """
  def render("row.json", %{row: row}) do
    %{
      level: row.level,
      code: row.code,
      name: row.name,
      total: row.total
    }
  end
end
