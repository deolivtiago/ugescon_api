defmodule ApiWeb.EntryView do
  @moduledoc """
  View responsible for rendering entries
  """
  use ApiWeb, :view

  alias Api.Accounting.Entry
  alias ApiWeb.EntryView

  @doc """
  Renders a list of entries
  """
  def render("index.json", %{entries: entries}) do
    %{success: true, data: render_many(entries, EntryView, "entry.json")}
  end

  @doc """
  Renders a single entry
  """
  def render("show.json", %{entry: entry}) do
    %{success: true, data: render_one(entry, EntryView, "entry.json")}
  end

  @doc """
  Renders a entry data
  """
  def render("entry.json", %{entry: entry}) do
    %{
      id: entry.id,
      type: Ecto.Enum.mappings(Entry, :type)[entry.type],
      value: entry.value,
      date: entry.date,
      description: entry.description,
      debit_account_code: entry.debit_account_code,
      credit_account_code: entry.credit_account_code,
      person_id: entry.person_id
    }
  end
end
